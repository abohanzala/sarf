import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getpackage;
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/support/support_list_model.dart';
import 'package:sarf/model/support/support_types.dart';
import 'package:sarf/src/widgets/loader.dart';

import '../../constant/api_links.dart';
import '../../model/support/support_detail_model.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';

class SupportController extends getpackage.GetxController {
  List<SingleSupport> supportTypes = <SingleSupport>[].obs;
  var selectedTypeName = ''.obs;
  var selectedTypeIndex = 0.obs;
  var selectedTypeId = ''.obs;
  var supportStatus = '1'.obs;
  List<File> uploadImages = <File>[].obs;
  var isLoadingSupport = false.obs;
  var isLoadingSupportDetails = false.obs;
  List<SingleSupportList> supportList = <SingleSupportList>[].obs;
  getpackage.Rx<SupportDetails> supportDetails = SupportDetails().obs;

  @override
  void onInit() async {
    
    super.onInit();
    await getSupportTypes();
    await getSupport('1');
  }

  Future getSupportTypes() async {
    // openLoader();

    var response = await DioClient()
        .get("${ApiLinks.getSupportTypes}${GetStorage().read('lang')}")
        .catchError((error) {
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
    if (response == null) return;

    if (response['success'] == true) {
      supportTypes.clear();
      var data = SupportTypes.fromJson(response);
      if (data.data!.isNotEmpty) {
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

  Future postNewSupport(String message) async {
    openLoader();
    // Map<String,dynamic> request = {
    //   'language': storage.read('lang'),
    //   'category_id': homeController.myCategories[categoryIndex.value].id,
    //   'sub_category_id': homeController.myCategories[categoryIndex.value]
    //       .subCategories![subCategoryIndex.value].id,
    //   'title': titleCtrl.text,
    //   'price': priceCtrl.text,
    //   'country_id': storage.read('country_id'),
    //   'city_id': storage.read('city_id'),
    //   'description': descCtrl.text,
    //   'images': images,
    // };
    // for(int i=0;i<images.length;i++){
    //     request.addAll({"images[$i]":images[i]});
    //   }
    //  print(request);

    FormData formData = FormData();

    for (var i = 0; i < uploadImages.length; i++) {
      var file = uploadImages[i];
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry("files[$i]",
          await MultipartFile.fromFile(file.path, filename: fileName)));
    }
    formData.fields
        .add(MapEntry('language', GetStorage().read('lang').toString()));
    formData.fields.add(MapEntry('type', selectedTypeId.value));
    formData.fields.add(MapEntry('message', message));
    debugPrint(formData.fields.toString());

    //debugPrint(formData.files.first.toString());

    //Dio http = API.getInstance();
    var response = await DioClient()
        .post(ApiLinks.addSupport, formData, true)
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
      
      uploadImages.clear();
      selectedTypeId.value = '';
      selectedTypeIndex.value = 0;
      selectedTypeName.value = '';
      getpackage.Get.back();
      getpackage.Get.snackbar('Success', response['message'].toString());
      //files.clear();

    } else {
      debugPrint('here');
      (response.containsKey('validation_errors'))
          ? getpackage.Get.snackbar(response['message'].toString(),
              response['validation_errors'].toString())
          // SnakeBars.showValidationErrorSnake(
          //     title: response['message'].toString(),
          //     description: response['validation_errors'].toString())
          : getpackage.Get.snackbar('Error', response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      Navigator.of(getpackage.Get.context!).pop();
    }
  }

  Future getSupport(String id) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    // openLoader();
    print('here');
    isLoadingSupport.value = true;
    var request = {
      "language": GetStorage().read('lang'),
      "status": id,
    };
    var response = await DioClient()
        .post(ApiLinks.getSupport, request)
        .catchError((error) {
      if (error is BadRequestException) {
        isLoadingSupport.value = false;
        var apiError = json.decode(error.message!);
        getpackage.Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: getpackage.SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        // print(error.toString());
      } else {
        isLoadingSupport.value = false;
        if (error is BadRequestException) {
          var message = error.message;
          getpackage.Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is FetchDataException) {
          var message = error.message;
          getpackage.Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is ApiNotRespondingException) {
          getpackage.Get.snackbar(
            'Error'.tr,
            'Oops! It took longer to respond.'.tr,
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        }
      }
    });
    debugPrint(response.toString());
    if (response == null) return;
    if (response['success'] == true) {
      supportList.clear();
      isLoadingSupport.value = false;
      debugPrint(response.toString());
      var data = SupportList.fromJson(response);
      //print( " asasasasasas ${data.data?.budgets?.length.toString()}" );
      if (data.data!.isNotEmpty) {
        for (var support in data.data!) {
          supportList.add(support);
        }
      }
      //print(budgets.first.name);

      // return data;
    } else {
      isLoadingSupport.value = false;
      debugPrint('here');
    }
    return null;
  }

  Future getSupportDetails(String id) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    // openLoader();
    isLoadingSupportDetails.value = true;
    var request = {
      "language": GetStorage().read('lang'),
      "support_id": id,
    };
    var response = await DioClient()
        .post(ApiLinks.getSupportDetails, request)
        .catchError((error) {
      if (error is BadRequestException) {
        isLoadingSupportDetails.value = false;
        var apiError = json.decode(error.message!);
        getpackage.Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: getpackage.SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        // print(error.toString());
      } else {
        isLoadingSupportDetails.value = false;
        if (error is BadRequestException) {
          var message = error.message;
          getpackage.Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is FetchDataException) {
          var message = error.message;
          getpackage.Get.snackbar(
            'Error'.tr,
            message.toString(),
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        } else if (error is ApiNotRespondingException) {
          getpackage.Get.snackbar(
            'Error'.tr,
            'Oops! It took longer to respond.'.tr,
            snackPosition: getpackage.SnackPosition.TOP,
            backgroundColor: R.colors.themeColor,
          );
        }
      }
    });
    debugPrint(response.toString());
    if (response == null) return;
    if (response['success'] == true) {
      supportList.clear();
      isLoadingSupportDetails.value = false;
      debugPrint(response.toString());
      var data = SupportDetails.fromJson(response);
      supportDetails.value = data;

      //print(budgets.first.name);

      // return data;
    } else {
      debugPrint('here');
    }
    return null;
  }

  Future supportReply(String id, String message) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    // openLoader();
    //  isLoadingSupportDetails.value = true;
    var request = {
      "language": GetStorage().read('lang'),
      "support_id": id,
      "message": message,
    };
    var response = await DioClient()
        .post(ApiLinks.supportReply, request)
        .catchError((error) {
      debugPrint(error.toString());
      //   if (error is BadRequestException) {
      //     isLoadingSupportDetails.value = false;
      //      var apiError = json.decode(error.message!);
      //     getpackage.Get.snackbar(
      //       'Error'.tr,
      //       apiError["reason"].toString(),
      //       snackPosition: getpackage.SnackPosition.TOP,
      //       backgroundColor: R.colors.themeColor,
      //     );
      //    // print(error.toString());
      //   } else {
      //     isLoadingSupportDetails.value = false;
      //   if (error is BadRequestException) {
      //   var message = error.message;
      //   getpackage.Get.snackbar(
      //       'Error'.tr,
      //       message.toString(),
      //       snackPosition: getpackage.SnackPosition.TOP,
      //       backgroundColor: R.colors.themeColor,
      //     );
      // } else if (error is FetchDataException) {
      //   var message = error.message;
      //   getpackage.Get.snackbar(
      //       'Error'.tr,
      //       message.toString(),
      //       snackPosition: getpackage.SnackPosition.TOP,
      //       backgroundColor: R.colors.themeColor,
      //     );
      // } else if (error is ApiNotRespondingException) {

      //   getpackage.Get.snackbar(
      //       'Error'.tr,
      //       'Oops! It took longer to respond.'.tr,
      //       snackPosition: getpackage.SnackPosition.TOP,
      //       backgroundColor: R.colors.themeColor,
      //     );
      // }

      //   }
    });
    debugPrint(response.toString());
    if (response == null) return;
    if (response['success'] == true) {
      getSupportDetails(id);
      // supportList.clear();
      // isLoadingSupportDetails.value = false;
      // debugPrint(response.toString());
      //   var data = SupportDetails.fromJson(response);
      //   supportDetails.value = data;

      //print(budgets.first.name);

      // return data;
    } else {
      debugPrint('here');
    }
    return null;
  }
}
