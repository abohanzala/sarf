// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/data_collection_controller.dart';
import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

class RegisterController extends GetxController {
  var registerFormKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  var code = "966".obs;
  var flag = "admin/country/sa.png".obs;
  var lenght = 9.obs;
  var selectedCountry = 2.obs;

  var message;

  Future register(String phoneNumber) async {
    openLoader();
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends

    var request = {
      'language': GetStorage().read('lang'),
      'mobile': phoneNumber,
    };
    debugPrint("This is my request====================$request");
    //DialogBoxes.openLoadingDialog();

    var response =
        await DioClient().post(ApiLinks.register, request).catchError((error) {
      Get.back();
      if (error is BadRequestException) {
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
    // debugPrint(response.toString());
    if (response['success'] == true) {
      Get.back();
      debugPrint(response.toString());
      Get.offNamed(RoutesName.OtpScreen);
      //   userInfo = UserInfo.fromMap(response);S
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
        message.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
    // return null;
  }
}
