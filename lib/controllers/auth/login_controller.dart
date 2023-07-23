import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:sarf/src/utils/routes_name.dart';
import '../../constant/api_links.dart';
import '../../model/loginModel.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../services/notification_services.dart';
import '../../src/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginController extends GetxController {
  String id = '';
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
   var code = "966".obs;
  var flag = "admin/country/sa.png".obs;
  var lenght = 9.obs;
  var selectedCountry = 2.obs;
 NotificationServices notificationServices = NotificationServices();

String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    // print("$input");
    return input;
  }

  Future login(String mob) async {
    openLoader();
    print("here");
    // String? result = await PlatformDeviceId.getDeviceId;
    String? result = await notificationServices.getDeviceToken();
    String pass = replaceArabicNumber(password.text);

    debugPrint(pass);
    
    var request = {};
    if(id == '' && !kIsWeb){
      print("here22");
      request = {
      'language': GetStorage().read('lang'),
      'mobile': mob,
      'password': pass,
      'ios_device_id': Platform.isIOS == true ? result : '',
      'android_device_id': Platform.isAndroid == true ? result : '',
    };
    }else{
      print("here21");
      request = {
      'language': GetStorage().read('lang'),
      'mobile': mob,
      'password': pass,
      
    };
    }

    if(id != "" && !kIsWeb){
      print("here25");
       request = {
      'language': GetStorage().read('lang'),
      'mobile': mob,
      'password': pass,
      "user_id" : id,
      'ios_device_id': Platform.isIOS == true ? result : '',
      'android_device_id': Platform.isAndroid == true ? result : '',
    };
    }else{
      print("here26");
      if(id != "" && kIsWeb){
        request = {
      'language': GetStorage().read('lang'),
      'mobile': mob,
      'password': pass,
      "user_id" : id,
      
    };
      }
      
    }
     
    debugPrint("This is my request====================$request");
    var response =
        await DioClient().post(ApiLinks.loginUser, request).catchError((error) {
          print("hhgg");
          debugPrint(error.toString());
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
      print("hereeeeeeee");
      print(userInfo.toString());
      phone.clear();
      password.clear();
      id = '';
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
      await GetStorage().write('user_lang', userInfo.user!.locale);
      await GetStorage().write('user_type', userInfo.user!.userType);
      await GetStorage().write('countryId', userInfo.user!.countryId);
      await GetStorage().write('accountType', userInfo.user!.accountType);
      await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com',
          GetStorage().read('mobile'));
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

  Future createFirebaseUser(String email, String password) async {
    await signIn(email, password);
    // // final user = firebase_auth.FirebaseAuth.instance.currentUser;
    // // print(user);
    // if (user != null) {
    //   print('firebaseUser');
    //   signIn();
    // } else {
    //   signUp();
    // }
  }

  Future signIn(String email, String password) async {
    // try {
    await firebase_auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // SnakeBars.showSuccessSnake(description: "FireBase signin");
      //Get.snackbar('FireBase signin', '');
    }).catchError((error) async {
      if (error.code == 'user-not-found') {
        await firebase_auth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          //  SnakeBars.showSuccessSnake(description: "FireBase Created");
          // Get.snackbar('FireBase created', '');
        }).catchError((error) {
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
