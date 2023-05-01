import 'dart:convert';

import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/viewer/viewer_model.dart';

import '../../constant/api_links.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/widgets/loader.dart';

class ViewersController extends GetxController{

// TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController password = TextEditingController();
Rx<ViewerModel> userData = ViewerModel().obs;
var code = "966".obs;
  var flag = "admin/country/sa.png".obs;
  var lenght = 9.obs;
  var selectedCountry = 2.obs;

@override
  void onInit() {
    getUsers();
    super.onInit();
  }


Future postNewCustomInvoice(String mobile,  String userPassword) async {
    openLoader();

debugPrint(mobile);    
   var request = {
      "language": GetStorage().read('lang'),
      "mobile": mobile,
      "password": userPassword
    };


    var response = await DioClient()
        .post(ApiLinks.addViewer, request, true)
        .catchError((error) {
          
      Get.back();
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        Get.snackbar('Error'.tr, apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.snackbar('Error'.tr, 'Something wnet wrong'.tr);
        debugPrint("aaaaaaaa${error.toString()}");
        //Navigator.of(Get.context!).pop();
        //HandlingErrors().handleError(error);
      }
    });

    // final response = await http.post(ApiLinks.addNewAdApi,data: formData );

    debugPrint("aaaaaaaaaaa$response");
    // Navigator.of(Get.context!).pop();
    if (response == null) return;
    if (response['success']) {
      
      Get.back();
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      
      // name.clear();
      phone.clear();
      password.clear();
      Get.back();
      Get.snackbar('Success'.tr, response['message'].toString());
      getUsers();
      //files.clear();

    } else {
      //uploadImages.clear();
      debugPrint('here');
      (response.containsKey('validation_errors'))
          ? Get.snackbar(response['message'].toString(),
              response['validation_errors'].toString())
          // SnakeBars.showValidationErrorSnake(
          //     title: response['message'].toString(),
          //     description: response['validation_errors'].toString())
          : Get.snackbar('Error'.tr, response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      Navigator.of(Get.context!).pop();
    }
  }

  Future removeViewer(String id,) async {
    

   
   var request = {
      "language": GetStorage().read('lang'),
      "id": id
    };


    var response = await DioClient()
        .post(ApiLinks.removeViewer, request, true)
        .catchError((error) {
          
      
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        Get.snackbar('Error'.tr, apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.snackbar('Error'.tr, 'Something went wrong'.tr);
        debugPrint("aaaaaaaa${error.toString()}");
        //Navigator.of(Get.context!).pop();
        //HandlingErrors().handleError(error);
      }
    });

    // final response = await http.post(ApiLinks.addNewAdApi,data: formData );

    debugPrint("aaaaaaaaaaa$response");
    // Navigator.of(Get.context!).pop();
    if (response == null) return;
    if (response['success']) {
      
      
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      
      // name.clear();
      
      Get.snackbar('Success'.tr, response['message'].toString());
      getUsers();
      //files.clear();

    } else {
      //uploadImages.clear();
      debugPrint('here');
      (response.containsKey('validation_errors'))
          ? Get.snackbar(response['message'].toString(),
              response['validation_errors'].toString())
          // SnakeBars.showValidationErrorSnake(
          //     title: response['message'].toString(),
          //     description: response['validation_errors'].toString())
          : Get.snackbar('Error'.tr, response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      
    }
  }

  Future getUsers() async {
    // openLoader();




    var response = await DioClient()
        .get(ApiLinks.getViewer)
        .catchError((error) {
          
      Get.back();
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        Get.snackbar('Error'.tr, apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.snackbar('Error'.tr, 'Something went wrong'.tr);
        debugPrint("aaaaaaaa${error.toString()}");
        //Navigator.of(Get.context!).pop();
        //HandlingErrors().handleError(error);
      }
    });

    // final response = await http.post(ApiLinks.addNewAdApi,data: formData );

    debugPrint("aaaaaaaaaaa$response");
    // Navigator.of(Get.context!).pop();
    if (response == null) return;
    if (response['success']) {
      
      userData.value = ViewerModel.fromJson(response);
      //files.clear();

    } else {
      //uploadImages.clear();
      debugPrint('here');
      if(response['message'] == 'data_not_found'){
        userData.value = ViewerModel();
      }
      
    }
  }


}