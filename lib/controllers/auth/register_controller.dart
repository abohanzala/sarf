// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';
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
  var length = 9.obs;
  var selectedCountry = 2.obs;
  String signature = "{{ app signature }}";

  var message;

  Future register(String phoneNumber) async {
    openLoader();
    try {
      // Get app signature asynchronously
      signature = await SmsAutoFill().getAppSignature;
      log(signature);

      var request = {
        'language': GetStorage().read('lang'),
        'mobile': phoneNumber,
        'app_signature_id': signature,
      };

      var response = await DioClient()
          .post(ApiLinks.register, request)
          .catchError((error) {
        Get.back();
        if (error is BadRequestException) {
          Get.snackbar(
            'Error'.tr,
            '$message',
            snackPosition: SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
          var apiError = json.decode(error.message!);
        } else {
          Get.back();
        }
      });
      message = response['message'];
      debugPrint("This is my response==================$response");
      debugPrint(response.toString());
      if (response['success'] == true) {
        Get.back();
        Get.offNamed(RoutesName.RegistrationDetails);
        // Get.offNamed(RoutesName.OtpScreen);
      } else {
        Get.back();
        Get.snackbar(
          'Error'.tr,
          message.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
  }
}
