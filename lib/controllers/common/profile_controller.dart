import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import 'package:sarf/model/moreModel/account_model.dart';
import 'package:sarf/src/Auth/change_password.dart';
import '../../constant/api_links.dart';
import '../../model/loginModel.dart';
import '../../model/moreModel/about.dart';
import '../../model/moreModel/profile.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/baseview/base_controller.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  var location = ''.obs;
  var location_lat = ''.obs;
  var location_lng = ''.obs;
  var message;
  ProfileModel? profileModel;
  Rx<UserAccounts> accounts = UserAccounts().obs;


  @override
  void onInit() {
    // GetStorage().write('lang', 'en');
    getProfile();
    getAccounts();
    super.onInit();
  }

  Future getProfile() async {
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    // var a = forgotPasswordController.phone.text;
    // final splitted = a.split('+');

    var request = {
      'language': GetStorage().read('lang'),
    };
    print("This is my request====================${request}");

    //DialogBoxes.openLoadingDialog();

    var response =
        await DioClient().post(ApiLinks.profile, request).catchError((error) {
      if (error is BadRequestException) {
        Get.back();
        Get.snackbar(
          'Error'.tr,
          '${message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        print(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        debugPrint('Something went Wrong===============${error.toString()}');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      debugPrint(response.toString());
      profileModel = ProfileModel.fromJson(response);
      print('This is ===================${profileModel}');
      nameController.text = profileModel!.user!.name == null
          ? ''
          : nameController.text = profileModel!.user!.name!;
      userNameController.text = profileModel!.user!.username == null
          ? ''
          : userNameController.text = profileModel!.user!.username!;
      emailController.text = profileModel!.user!.email == null
          ? ''
          : emailController.text = profileModel!.user!.email!;
      mobileController.text = profileModel!.user!.mobile == null
          ? ''
          : mobileController.text = profileModel!.user!.mobile!;
      instaController.text = profileModel!.user!.userDetail!.instaLink == null
          ? ''
          : profileModel!.user!.userDetail!.instaLink!;
      twitterController.text =
          profileModel!.user!.userDetail!.twitterLink == null
              ? ''
              : profileModel!.user!.userDetail!.twitterLink!;
      contactController.text = profileModel!.user!.userDetail!.contactNo == null
          ? ''
          : profileModel!.user!.userDetail!.contactNo!;
      whatsappController.text = profileModel!.user!.userDetail!.whatsapp == null
          ? ''
          : profileModel!.user!.userDetail!.whatsapp!;
      websiteController.text = profileModel!.user!.userDetail!.website == null
          ? ''
          : profileModel!.user!.userDetail!.website!;
      location.value = profileModel!.user!.userDetail!.location == null
          ? ''
          : profileModel!.user!.userDetail!.location!;
      update();
      //   Get.toNamed(RoutesName.RegistrationDetails);
      //   userInfo = UserInfo.fromMap(response);
      //  await  storage.write('user_token', userInfo.token);
      //  await storage.write('userId', userInfo.user!.id);
      //  await storage.write('name', userInfo.user!.name);
      //  await storage.write('username', userInfo.user!.username);
      //  await storage.write('email', userInfo.user!.email);
      //  await storage.write('firebase_email', userInfo.user!.firebaseEmail);
      //  await storage.write('mobile', userInfo.user!.mobile);
      //  await storage.write('photo', userInfo.user!.photo);
      //  await storage.write('status', userInfo.user!.status);
      //   Navigator.of(Get.context!).pop();

      //  await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com', GetStorage().read('mobile')).then((value){
      //     SnakeBars.showSuccessSnake(description: userInfo.message);
      //     Get.offNamed(Routes.BOTTOM_NAVIGATION);
      //   }).catchError((error){
      //     SnakeBars.showErrorSnake(description: error.toString());
      //   });

    } else {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        '${message}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
      // SnakeBars.showErrorSnake(description: response['message']);
      // Navigator.of(Get.context!).pop();
    }
    return null;
    // return null;
  }

  Future getAccounts() async {
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    // var a = forgotPasswordController.phone.text;
    // final splitted = a.split('+');

    var request = {
      'language': GetStorage().read('lang'),
    };
    

    //DialogBoxes.openLoadingDialog();

    var response =
        await DioClient().post(ApiLinks.getAccounts, request).catchError((error) {
      if (error is BadRequestException) {
        
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        
        debugPrint('Something went Wrong===============${error.toString()}');
        //HandlingErrors().handleError(error);
      }
    });
    //message = response['message'];
    debugPrint("This ==================$response");
    if (response['success'] == true) {
     //debugPrint("This ==================$response");
     var data = UserAccounts.fromJson(response);
      accounts.value = data;

    } else {
      debugPrint(response.toString());
    }
    return null;
    // return null;
  }
  Future login(String phone,String password,String groupId) async {
    openLoader();
    
    var request = {
      'language': GetStorage().read('lang'),
      'mobile': phone,
      'password': password,
      'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
      'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
      "group_id" : groupId
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
       MyBottomNavigationController ctr =
      Get.put<MyBottomNavigationController>(MyBottomNavigationController());
  ctr.tabIndex.value = 0;
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
