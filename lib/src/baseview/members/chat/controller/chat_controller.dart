// import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart" as getpackage;

import '../../../../../constant/api_links.dart';
// import '../../../../../services/app_exceptions.dart';
import '../../../../../services/dio_client.dart';

class ChatController extends getpackage.GetxController{

  Future<String> uploadFirebaseFile(File file,String name) async {
    //openLoader();
    String url = "";
    FormData formData = FormData();

    
      String fileName = name;
      formData.files.add(MapEntry("file",
          await MultipartFile.fromFile(file.path, filename: fileName)));
    
    

    //debugPrint(formData.files.first.toString());

    //Dio http = API.getInstance();
    var response = await DioClient()
        .post(ApiLinks.firebaseFileStorage, formData, true)
        .catchError((error) {
          debugPrint(error.toString());
      // getpackage.Get.back();
      // if (error is BadRequestException) {
      //   var apiError = json.decode(error.message!);
      //   debugPrint("aaaaaaaa${error.toString()}");
      //   getpackage.Get.snackbar('Error', apiError["reason"].toString());
      //   //DialogBoxes.showErroDialog(description: apiError["reason"]);
      // } else {
      //   getpackage.Get.snackbar('Error', 'Something went wrong');
      //   debugPrint("aaaaaaaa${error.toString()}");
      //   //Navigator.of(getpackage.Get.context!).pop();
      //   //HandlingErrors().handleError(error);
      // }
    });

    // final response = await http.post(ApiLinks.addNewAdApi,data: formData );

    debugPrint("aaaaaaaaaaa$response");
    // Navigator.of(getpackage.Get.context!).pop();
    if (response == null) return url;
    if (response['success']) {
      //getpackage.Get.back();
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      url = response['file_path'];
      // uploadImages.clear();
      // mobile1.clear();
      // amount2.clear();
      // note3.clear();
      // getpackage.Get.back();
      // getpackage.Get.snackbar('Success', response['message'].toString());
      //files.clear();

    } else {
      //uploadImages.clear();
      debugPrint('here');
      (response.containsKey('validation_errors'))
          ? getpackage.Get.snackbar(response['message'].toString(),
              response['validation_errors'].toString())
          // SnakeBars.showValidationErrorSnake(
          //     title: response['message'].toString(),
          //     description: response['validation_errors'].toString())
          : getpackage.Get.snackbar('Error', response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      
    }
    return url;
  }

}