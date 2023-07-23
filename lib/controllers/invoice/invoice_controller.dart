import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getpackage;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarf/model/members/invoice_list_model.dart';
import 'package:sarf/services/app_exceptions.dart';

import '../../constant/api_links.dart';
import '../../model/invoice/invoice_members_home.dart';
import '../../model/invoice/invoice_members_model.dart';
import '../../model/invoice/searched_mobile_model.dart';
import '../../services/dio_client.dart';
import '../../src/widgets/loader.dart';

class InvoiceController extends getpackage.GetxController {
  List<File> uploadImages = <File>[].obs;
  var selectedBudgetId = "".obs;
  var selectedExptId = "".obs;
  var selectedBudgetName = "Select Category".obs;
  var selectedExpName = "Select Expanse".obs;
  // var selectedBudgetName = "Select Category".obs;
  // List<File> uploadImages2 = <File>[].obs;
  var qrCode = "".obs;
  var filter = 0;
  bool checkMobile = false;
  getpackage.Rx<SearchedMobileList> searchedUsers = SearchedMobileList().obs;
  TextEditingController mobile1 = TextEditingController();
  TextEditingController amount2 = TextEditingController();
  TextEditingController amount22 = TextEditingController();
  TextEditingController note3 = TextEditingController();
  TextEditingController note33 = TextEditingController();

  Future postNewInvoice(String mobile, String amount, String note) async {
    openLoader();

    FormData formData = FormData();
    if (kIsWeb) {
       for (var i = 0; i < uploadImages.length; i++) {
      var file = uploadImages[i];
      var xfile = XFile(uploadImages[i].path);
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry("file_attach[$i]",
          await MultipartFile.fromBytes( await xfile.readAsBytes().then((value) {
                return value.cast();
              }), filename: fileName)));
    }
    }else{
       for (var i = 0; i < uploadImages.length; i++) {
      var file = uploadImages[i];
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry("file_attach[$i]",
          await MultipartFile.fromFile(file.path, filename: fileName)));
    }
    }
   
    formData.fields
        .add(MapEntry('language', GetStorage().read('lang').toString()));
    formData.fields.add(MapEntry('mobile', mobile));
    formData.fields.add(MapEntry('amount', amount));
    formData.fields.add(MapEntry('note', note));
    formData.fields.add(const MapEntry('paid_status', "0"));
    debugPrint(formData.fields.toString());

    //debugPrint(formData.files.first.toString());

    //Dio http = API.getInstance();
    var response = await DioClient()
        .post(ApiLinks.simpleInvoice, formData, true)
        .catchError((error) {
      checkMobile = false;    
      getpackage.Get.back();
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        getpackage.Get.snackbar('Error'.tr, apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        getpackage.Get.snackbar('Error'.tr, "Something wnet wrong".tr);
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
      checkMobile = false;
      getpackage.Get.back();
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      
      uploadImages.clear();
      mobile1.clear();
      amount2.clear();
      note3.clear();
      getpackage.Get.back();
      getpackage.Get.snackbar('Success'.tr, response['message'].toString());
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
          : getpackage.Get.snackbar('Error'.tr, response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      Navigator.of(getpackage.Get.context!).pop();
    }
  }

  Future postNewCustomInvoice(String bid, String expId ,String amount, String note) async {
    openLoader();

    FormData formData = FormData();

    // for (var i = 0; i < uploadImages.length; i++) {
    //   var file = uploadImages[i];
    //   String fileName = file.path.split('/').last;
    //   formData.files.add(MapEntry("file_attach[$i]",
    //       await MultipartFile.fromFile(file.path, filename: fileName)));
    // }
     if (kIsWeb) {
       for (var i = 0; i < uploadImages.length; i++) {
      var file = uploadImages[i];
      var xfile = XFile(uploadImages[i].path);
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry("file_attach[$i]",
          await MultipartFile.fromBytes( await xfile.readAsBytes().then((value) {
                return value.cast();
              }), filename: fileName)));
    }
    }else{
       for (var i = 0; i < uploadImages.length; i++) {
      var file = uploadImages[i];
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry("file_attach[$i]",
          await MultipartFile.fromFile(file.path, filename: fileName)));
    }
    }
    formData.fields
        .add(MapEntry('language', GetStorage().read('lang').toString()));
    formData.fields.add(MapEntry('budget_id', bid));
    formData.fields.add(MapEntry('expense_type_id', expId));
    formData.fields.add(MapEntry('amount', amount));
    formData.fields.add(MapEntry('note', note));
    
    debugPrint(formData.fields.toString());

    //debugPrint(formData.files.first.toString());

    //Dio http = API.getInstance();
    var response = await DioClient()
        .post(ApiLinks.customSimpleInvoice, formData, true)
        .catchError((error) {
      checkMobile = false;    
      getpackage.Get.back();
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        debugPrint("aaaaaaaa${error.toString()}");
        getpackage.Get.snackbar('Error'.tr, apiError["reason"].toString());
        //DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        getpackage.Get.snackbar('Error'.tr, 'Something went wrong'.tr);
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
      checkMobile = false;
      getpackage.Get.back();
      //SnakeBars.showSuccessSnake(description: response['message'].toString());
      
      uploadImages.clear();
      selectedBudgetId.value = '';
      selectedExptId.value = '';
      selectedBudgetName.value = "Select Category";
      selectedExpName.value = "Select Expanse";

      amount22.clear();
      note33.clear();
      getpackage.Get.back();
      getpackage.Get.snackbar('Success'.tr, response['message'].toString());
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
          : getpackage.Get.snackbar('Error'.tr, response['message'].toString());
      //SnakeBars.showErrorSnake(description: response['message'].toString());
      Navigator.of(getpackage.Get.context!).pop();
    }
  }


  Future<InvoiceMemberListModel?> getInvoiceMemberList(String query) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //  openLoader();
    var request = {};
    if(query == ''){
    request = {
      "language": GetStorage().read('lang'),
      
    };
   }else{
    request = {
      "language": GetStorage().read('lang'),
      "query_string": query,
    };
   }
    var response = await DioClient()
        .post(ApiLinks.invoiceMemList,request)
        .catchError((error) {
          debugPrint(error.toString());
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
    if(response == null ) return null;
    if (response['success'] == true) {
      // getpackage.Get.back();
      debugPrint(response.toString());
      var membersList = InvoiceMemberListModel.fromJson(response);
      //print(membersList.data?.first.expenseName);
      return membersList;
    } else {
      // getpackage.Get.back();
      debugPrint('here');
    }
    return null;
  }

  
  
  
  Future<InvoiceMemberListModelHome?> getInvoiceMemberListHome(String query,String expanseId,String bId) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //  openLoader();
   var request = {};
    if(query == ''){
    request = {
      "language": GetStorage().read('lang'),
      "expense_type_id" : expanseId,
      "budget_id" : bId,
      
    };
   }else{
    request = {
      "language": GetStorage().read('lang'),
      "query_string": query,
      "expense_type_id" : expanseId,
      "budget_id" : bId,
    };
   }
   debugPrint(request.toString());
    var response = await DioClient()
        .post(ApiLinks.invoiceMemList,request)
        .catchError((error) {
          debugPrint(error.toString());
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
    if(response == null ) return null;
    if (response['success'] == true) {
      // getpackage.Get.back();
      debugPrint(response.toString());
      var membersList = InvoiceMemberListModelHome.fromJson(response);
      //print(membersList.data?.first.expenseName);
      return membersList;
    } else {
      // getpackage.Get.back();
      debugPrint('here');
    }
    return null;
  }



   Future<InvoiceList?> getInvoiceListMember(String query,String memberID) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //  openLoader();
    var request = {};
    if(query == ''){
    request = {
      "language": GetStorage().read('lang'),
      "member_id": memberID
      
    };
   }else{
    request = {
      "language": GetStorage().read('lang'),
      "query_string": query,
      "member_id": memberID
    };
   }
    var response = await DioClient()
        .post("${ApiLinks.invoiceListNew}",request)
        .catchError((error) {
          debugPrint(error.toString());
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
    if(response == null ) return null;
    if (response['success'] == true) {
      // getpackage.Get.back();
      debugPrint(response.toString());
      var membersList = InvoiceList.fromJson(response);
      //print(membersList.data?.first.expenseName);
      return membersList;
    } else {
      // getpackage.Get.back();
      debugPrint('here');
    }
    return null;
  }

  Future<InvoiceList?> getInvoiceList(String query,) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //  openLoader();
    var request = {};
    if(query == ''){
    request = {
      "language": GetStorage().read('lang'),
      
    };
   }else{
    request = {
      "language": GetStorage().read('lang'),
      "query_string": query,
    };
   }
    var response = await DioClient()
        .post("${ApiLinks.invoiceList}${GetStorage().read('lang')}",request)
        .catchError((error) {
          debugPrint(error.toString());
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
    if(response == null ) return null;
    if (response['success'] == true) {
      // getpackage.Get.back();
      debugPrint(response.toString());
      var membersList = InvoiceList.fromJson(response);
      //print(membersList.data?.first.expenseName);
      return membersList;
    } else {
      // getpackage.Get.back();
      debugPrint('here');
    }
    return null;
  }

  //  Future<InvoiceList?> getInvoiceListHome(String query,String expenseId,String bId) async {
  //   //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
  //   //  openLoader();
  //   var request = {};
  //   if(query == ''){
  //   request = {
  //     "language": GetStorage().read('lang'),
  //     "expense_id" : expenseId,
  //     "budget_id" : bId,
      
  //   };
  //  }else{
  //   request = {
  //     "language": GetStorage().read('lang'),
  //     "query_string": query,
  //     "expense_id" : expenseId,
  //     "budget_id" : bId,
  //   };
  //  }
  //   var response = await DioClient()
  //       .post("${ApiLinks.invoiceList}${GetStorage().read('lang')}",request)
  //       .catchError((error) {
  //         debugPrint(error.toString());
  //     if (error is BadRequestException) {
  //       // print(error.toString());
  //     } else {
  //       //print(error.toString());

  //       if (error is BadRequestException) {
  //         // print(error.toString());

  //       } else if (error is FetchDataException) {
  //         // print(error.toString());

  //       } else if (error is ApiNotRespondingException) {
  //         //print(error.message.toString());
  //       }
  //     }
  //   });
  //   if(response == null ) return null;
  //   if (response['success'] == true) {
  //     // getpackage.Get.back();
  //     debugPrint(response.toString());
  //     var membersList = InvoiceList.fromJson(response);
  //     //print(membersList.data?.first.expenseName);
  //     return membersList;
  //   } else {
  //     // getpackage.Get.back();
  //     debugPrint('here');
  //   }
  //   return null;
  // }

  Future<InvoiceList?> getInvoiceListHome(String query,String expenseId,String bId,String memberID) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    // openLoader();
    // expense_id
    var request = {};
    if(query == ''){
    request = {
      "language": GetStorage().read('lang'),
      "expense_type_id" : expenseId,
      "budget_id" : bId,
      "member_id": memberID
      
    };
   }else{
    request = {
      "language": GetStorage().read('lang'),
      "query_string": query,
      "expense_type_id" : expenseId,
      "budget_id" : bId,
      "member_id": memberID
    };
   }
   debugPrint(request.toString());
    var response = await DioClient()
        .post("${ApiLinks.invoiceListNew}",request)
        .catchError((error) {
          debugPrint(error.toString());
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
    if(response == null ) return null;
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

  Future mobileCheck(String number) async {
    var data;
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    // openLoader();
    //  isLoadingSupportDetails.value = true;
    var request = {
      "language": GetStorage().read('lang'),
      "mobile": number,
      "is_invoice": true,
    };
    var response = await DioClient()
        .post(ApiLinks.mobileCheckInvoice, request)
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
      // print(response['message']);
      // print(response['user']['name']);
      data = response;
      //getSupportDetails(id);
      // supportList.clear();
      // isLoadingSupportDetails.value = false;
      // debugPrint(response.toString());
      //   var data = SupportDetails.fromJson(response);
      //   supportDetails.value = data;

      //print(budgets.first.name);

      // return data;
    } else {
      data = response;
      debugPrint('here');
    }
    return data;
  }

  Future getMobileUsers(String number) async {
    searchedUsers.value = SearchedMobileList();
    var request = {
      "mobile": number,
    };
    var response = await DioClient()
        .post(ApiLinks.getUserList, request)
        .catchError((error) {
      debugPrint(error.toString());
     
    });
    // debugPrint(response.toString());
    if (response == null) return;
    if (response['success'] == true) {
      // debugPrint(response.toString());
      var data = SearchedMobileList.fromJson(response);
      searchedUsers.value = data;
      debugPrint(searchedUsers.value.data.toString());
      
    } else {
      searchedUsers.value = SearchedMobileList();
      debugPrint('here error');
    }
    return null;
  }
}
