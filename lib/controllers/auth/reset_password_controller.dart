import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/login_controller.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import 'package:sarf/src/Auth/change_password.dart';
import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';
import 'forgot_password_controller.dart';

class ResetPasswordController extends GetxController {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  LoginController loginController = Get.find<LoginController>();
  var message;

  @override
  void onInit() {
    // GetStorage().write('lang', 'en');
    super.onInit();
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


  Future resetPassword() async {
    openLoader();
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    var a = loginController.phone.text;
    final splitted = a.split('+');
    String currentPass = replaceArabicNumber(currentPassword.text);
    String newPass = replaceArabicNumber(newPassword.text);
    String conformPass = replaceArabicNumber(confirmNewPassword.text);
    var request = {
      'language': GetStorage().read('lang'),
      'mobile': loginController.phone.text,
      'current_password': currentPass,
      'new_password': newPass,
      'confirm_password': conformPass,
    };
    print("This is my request====================${request}");

    //DialogBoxes.openLoadingDialog();

    var response = await DioClient()
        .post(ApiLinks.change_password, request)
        .catchError((error) {
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
        debugPrint('Something went Wrong');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      Get.toNamed(RoutesName.LogIn);
      debugPrint(response.toString());
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
}
