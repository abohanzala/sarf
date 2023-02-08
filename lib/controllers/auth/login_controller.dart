import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/src/utils/routes_name.dart';
import '../../constant/api_links.dart';
import '../../model/loginModel.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginController extends GetxController {
  var loginFormKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    
    super.onInit();
  }

  Future login() async {
    openLoader();
    var a = phone.text;
    final splitted = a.split('+');
    var request = {
      'language': GetStorage().read('lang'),
      'mobile': splitted[1],
      'password': password.text,
      'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
      'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
    };
    debugPrint("This is my request====================$request");
    var response =
        await DioClient().post(ApiLinks.loginUser, request).catchError((error) {
      if (error is BadRequestException) {
        Get.back();
        var apiError = json.decode(error.message!);
        Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
      } else {
        Get.back();
        if (error is BadRequestException) {
          var message = error.message;
          Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is FetchDataException) {
          var message = error.message;
          Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is ApiNotRespondingException) {
          Get.snackbar(
            'Error'.tr,
            'Oops! It took longer to respond.'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        }
      }
    });
    debugPrint(response.toString());
    if (response['success'] == true) {
      Get.back();
      debugPrint(response.toString());
      Get.snackbar(
        'Success'.tr,
        'Login Successfully'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.blue,
      );
      var userInfo = LoginModel.fromJson(response);
      phone.clear();
      password.clear();
      await GetStorage().write('user_token', userInfo.token);
      await GetStorage().write('userId', userInfo.user!.id);
      await GetStorage().write('name', userInfo.user!.name);
      await GetStorage().write('username', userInfo.user!.username);
      await GetStorage().write('email', userInfo.user!.email);
      await GetStorage().write('firebase_email', userInfo.user!.firebaseEmail);
      await GetStorage().write('mobile', userInfo.user!.mobile);
      await GetStorage().write('photo', userInfo.user!.photo);
      await GetStorage().write('status', userInfo.user!.status);
      await GetStorage().write('groupId', userInfo.user!.groupId);
      await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com', GetStorage().read('mobile'));
      Get.offAllNamed(RoutesName.base);
    } else {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        response['message'].toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
  }
  Future createFirebaseUser(String email,String password) async {
    await signIn(email,password);
    // // final user = firebase_auth.FirebaseAuth.instance.currentUser;
    // // print(user);
    // if (user != null) {
    //   print('firebaseUser');
    //   signIn();
    // } else {
    //   signUp();
    // }
  }

  Future signIn(String email,String password) async {
    // try {
      await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password).then((value){
            // SnakeBars.showSuccessSnake(description: "FireBase signin");
            //Get.snackbar('FireBase signin', '');
          }).catchError((error) async{
            if (error.code == 'user-not-found' ) {
              await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password).then((value){
                //  SnakeBars.showSuccessSnake(description: "FireBase Created");
               // Get.snackbar('FireBase created', '');
              }).catchError((error){
                // DialogBoxes.showErroDialog(description: error.code);
              });
              
            }
            // DialogBoxes.showErroDialog(description: error.code);
            debugPrint('Firebase signin ${error.code}');
          });

          //  final user = _auth.currentUser;
          //   if (user != null) {
          //     loggedInUser = user;
          //     // print(loggedInUser?.email);
          //   }
      
    // } catch (e) {
    //   //var error =
      
    //    //debugPrint('Firebase signin ${e['code']}');
    // }

   
  }

  Future signUp() async {
    try {
      await firebase_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: GetStorage().read('mobile') + '@gmail.com',
          password: GetStorage().read('mobile'));
    } catch (e) {
      debugPrint('Firebase signUp $e');
    }
  }
}
