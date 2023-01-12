import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getpackage;
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/members/invoice_list_model.dart';
import 'package:sarf/services/app_exceptions.dart';

import '../../constant/api_links.dart';
import '../../services/dio_client.dart';
import '../../src/widgets/loader.dart';

class InvoiceController extends getpackage.GetxController{

 List<File> uploadImages = <File>[].obs;
 
  Future postNewInvoice(String mobile,String amount,String note) async {
  openLoader();
    
   
    FormData formData = FormData();
    
for (var i = 0; i < uploadImages.length; i++) {
  var file = uploadImages[i];
  String fileName = file.path.split('/').last;
  formData.files.add(
    MapEntry("file_attach[$i]", await MultipartFile.fromFile(file.path, filename: fileName))
   );
}
  formData.fields.add(MapEntry('language', GetStorage().read('lang').toString()));
  formData.fields.add(MapEntry('mobile', mobile));
  formData.fields.add(MapEntry('amount', amount));
  formData.fields.add(MapEntry('note', note));
  formData.fields.add(const MapEntry('paid_status', "0"));
  debugPrint(formData.fields.toString());
  
   //debugPrint(formData.files.first.toString());
    
    //Dio http = API.getInstance();
    var response = await DioClient()
        .post(ApiLinks.simpleInvoice, formData,true)
        .catchError((error) {
          getpackage.Get.back();
      if (error is BadRequestException) {
        
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        getpackage.Get.snackbar('Error', apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        getpackage.Get.snackbar('Error', 'Something went wrong');
        debugPrint("aaaaaaaa${error.toString()}");
        //Navigator.of(getpackage.Get.context!).pop();
        //HandlingErrors().handleError(error);
      }
    });

    // final response = await http.post(ApiLinks.addNewAdApi,data: formData );
    
     
      debugPrint("aaaaaaaaaaa$response");
    // Navigator.of(getpackage.Get.context!).pop();
    if (response == null) return;
    if (response['success']) {
      getpackage.Get.back();
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      getpackage.Get.snackbar('Success', response['message'].toString());
      uploadImages.clear();
      getpackage.Get.back();
      //files.clear();
      
      
    } else {
      uploadImages.clear();
      debugPrint('here');
      (response.containsKey('validation_errors'))
          ? getpackage.Get.snackbar(response['message'].toString(), response['validation_errors'].toString())
          // SnakeBars.showValidationErrorSnake(
          //     title: response['message'].toString(),
          //     description: response['validation_errors'].toString())
          : getpackage.Get.snackbar('Success', response['message'].toString());
          //SnakeBars.showErrorSnake(description: response['message'].toString());
      Navigator.of(getpackage.Get.context!).pop();
    }
  }

   Future<InvoiceList?> getInvoiceList() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
   // openLoader();
    var response =
        await DioClient().get("${ApiLinks.invoiceList}${GetStorage().read('lang')}").catchError((error) {
      if (error is BadRequestException) {
        
        
       // print(error.toString());
      } else {

        //print(error.toString());
        
    if (error is BadRequestException) {
     // print(error.toString());
      
    } else if (error is FetchDataException) {
     // print(error.toString());
      
    } else if (error is ApiNotRespondingException) {
      //print(error.message.toString());
    }

      }
    }); 
    if (response['success'] == true) {
     
      debugPrint(response.toString());
        var membersList = InvoiceList.fromJson(response);
        //print(membersList.data?.first.expenseName);
        return membersList;
    } else {
      debugPrint('here');
    }
    return null;
  }

}