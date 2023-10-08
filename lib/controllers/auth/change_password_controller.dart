// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';
import 'forgot_password_controller.dart';

class ChangePasswordController extends GetxController {
  TextEditingController otp = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();
  var message;
  var codeVal = Rx<String>('');

  @override
  void onInit() {
    // GetStorage().write('lang', 'en');
    super.onInit();
    otpListener();
  }

  void otpListener() async {
    var status = await Permission.sms.request();
    if (status.isGranted) {
      await SmsAutoFill().unregisterListener();
      // listenForCode();
      await SmsAutoFill().listenForCode();
    } else {
      // print('SMS permission denied');
    }
    // print("lestener called");
  }

  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    // print("$input");
    return input;
  }

  Future changePassword(String otpText) async {
    openLoader();
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    var a =
        "${forgotPasswordController.code}${forgotPasswordController.phone.text}";
    String newPass = replaceArabicNumber(newPassword.text);
    String confirmPass = replaceArabicNumber(confirmNewPassword.text);

    var request = {
      'language': GetStorage().read('lang'),
      'mobile': a,
      'otp': replaceArabicNumber(otpText),
      'new_password': newPass,
      'confirm_password': confirmPass,
    };
    // debugPrint("This is my request====================$request");

    //DialogBoxes.openLoadingDialog();

    var response = await DioClient()
        .post(ApiLinks.reset_password, request)
        .catchError((error) {
      if (error is BadRequestException) {
        Get.back();
        Get.snackbar(
          'Error'.tr,
          '$message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        // debugPrint(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        // debugPrint('Something went Wrong');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    // debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      Get.toNamed(RoutesName.LogIn);
      otp.clear();
      newPassword.clear();
      confirmNewPassword.clear();
      forgotPasswordController.toString();

      // debugPrint(response.toString());
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
        '$message',
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
      // SnakeBars.showErrorSnake(description: response['message']);
      // Navigator.of(Get.context!).pop();
    }
    return null;
    // return null;
  }
}
