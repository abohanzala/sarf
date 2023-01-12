import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/alerts/alert_model.dart';

import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';

class AlertsController extends GetxController{
  var isLoadingAlert = false.obs;
  Rx<Notifications> alerts = Notifications().obs;

 Future getAlerts() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
   // openLoader();
   isLoadingAlert.value = true;
   var request = {
    "language": GetStorage().read('lang'),
   };
    var response =
        await DioClient().post(ApiLinks.alerts, request).catchError((error) {
      if (error is BadRequestException) {
        isLoadingAlert.value = false;
         var apiError = json.decode(error.message!);
        Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
       // print(error.toString());
      } else {
        isLoadingAlert.value = false;
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
    if(response == null) return; 
    if (response['success'] == true) {
      isLoadingAlert.value = false;
      debugPrint(response.toString());
        var data = Notifications.fromJson(response);
        alerts.value = data;
       
    } else {
      isLoadingAlert.value = false;
      debugPrint('here');
    }
    return null;
  }


  Future clearAlerts() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
   // openLoader();
   isLoadingAlert.value = true;
   var request = {
    "language": GetStorage().read('lang'),
   };
    var response =
        await DioClient().post(ApiLinks.alertsClear, request).catchError((error) {
      if (error is BadRequestException) {
        isLoadingAlert.value = false;
         var apiError = json.decode(error.message!);
        Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
       // print(error.toString());
      } else {
        isLoadingAlert.value = false;
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
    if(response == null) return; 
    if (response['success'] == true) {
      isLoadingAlert.value = false;
      debugPrint(response.toString());
      
        alerts.value = Notifications();
       
    } else {
      isLoadingAlert.value = false;
      Get.snackbar(
          'Error'.tr,
          response['message'].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
      debugPrint('here');
    }
    return null;
  }



}