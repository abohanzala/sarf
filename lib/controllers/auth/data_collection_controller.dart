import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/data_collection.dart';

import '../../constant/api_links.dart';

import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';


class DataCollectionController extends GetxController {
  var loginFormKey = GlobalKey<FormState>();
  List<Cities>? cities = [];
  List<ExpenseType>? types = [];

  @override
  void onInit() {
    GetStorage().write('lang', 'en');
    super.onInit();
  }

  Future dataCollection() async {
    var response = await DioClient()
        .get(
      ApiLinks.data_collection,
    )
        .catchError((error) {
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
    if (response['success'] == true) {
      debugPrint(response.toString());
      var data = DataCollection.fromJson(response);
      cities = data.data!.cities;
      types = data.data!.expenseType!;
      // await GetStorage().write('user_token', userInfo.token);
      // await GetStorage().write('userId', userInfo.user!.id);
      // await GetStorage().write('name', userInfo.user!.name);
      // await GetStorage().write('username', userInfo.user!.username);
      // await GetStorage().write('email', userInfo.user!.email);
      // await GetStorage().write('firebase_email', userInfo.user!.firebaseEmail);
      // await GetStorage().write('mobile', userInfo.user!.mobile);
      // await GetStorage().write('photo', userInfo.user!.photo);
      // await GetStorage().write('status', userInfo.user!.status);
      // Get.offAllNamed(RoutesName.base);
    } else {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        'Something wnet wrong try later'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
  }
}
