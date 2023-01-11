import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/support/support_types.dart';

import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';

class SupportController extends GetxController{

  List<SingleSupport> supportTypes = <SingleSupport>[].obs;
  var selectedTypeName = ''.obs;
  var selectedTypeIndex = 0.obs;
  var selectedTypeId = ''.obs;

  @override
  void onInit() async{
    await getSupportTypes();
    super.onInit();
  
    
  }


Future getSupportTypes() async {
    
   // openLoader();
   
   
    var response =
        await DioClient().get("${ApiLinks.getSupportTypes}${GetStorage().read('lang')}").catchError((error) {
          debugPrint(error.toString());
      if (error is BadRequestException) {
    //     //loading.value = false;
    //      var apiError = json.decode(error.message!);
    //     // Get.snackbar(
    //     //   'Error'.tr,
    //     //   apiError["reason"].toString(),
    //     //   snackPosition: SnackPosition.TOP,
    //     //   backgroundColor: R.colors.themeColor,
    //     // );
    //    // print(error.toString());
    //   } else {
    //     //loading.value = false;
    //   if (error is BadRequestException) {
    //   var message = error.message;
    //   Get.snackbar(
    //       'Error'.tr,
    //       message.toString(),
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: R.colors.themeColor,
    //     );
    // } else if (error is FetchDataException) {
    //   var message = error.message;
    //   Get.snackbar(
    //       'Error'.tr,
    //       message.toString(),
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: R.colors.themeColor,
    //     );
    // } else if (error is ApiNotRespondingException) {
      
    //   Get.snackbar(
    //       'Error'.tr,
    //       'Oops! It took longer to respond.'.tr,
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: R.colors.themeColor,
    //     );
    // }

    //   }
      }
    });
   // print(response);
    if(response == null) return; 
    
    
    if (response['success'] == true) {
      supportTypes.clear();
      var data = SupportTypes.fromJson(response);
      if(data.data!.isNotEmpty){
          for (var supportType in data.data!) {
          supportTypes.add(supportType);
        }
        }
         print(supportTypes.first.name?.en);

    } else {
      debugPrint('here');
    }
    return null;
  }



}