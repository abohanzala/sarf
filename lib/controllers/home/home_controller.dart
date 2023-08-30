import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/home/home_model.dart';

import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

class HomeController extends GetxController{

var loading = false.obs; 
List<Budgets> budgets = <Budgets>[].obs;
List<ExpenseTypes> expenseTypes = <ExpenseTypes>[].obs;
var selectedBudgetIndex = 0.obs;
var selectedBudgetId = ''.obs;
var selectedBudgetNumbder = "".obs;
var selectedBudgetName = "".obs;
var qrCode = "".obs;
var alertCount = 0.obs;
//var expansetype = ''.obs;
var currency = ''.obs;
var totalInvoicesDaily = ''.obs;
var totalInvoicesMontly = ''.obs;
var totalInvoicesYearly = ''.obs;
var totalExpansesDaily = ''.obs;
var totalExpansesMontly = ''.obs;
var totalExpansesYearly = ''.obs;
// var expanse = 'All'.obs;
// var expansesId = '0'.obs;


@override
void onInit() async{
 // await getHome(null);
  super.onInit();
  
}

Future getHome(String? id,int? day,int? month,int? year) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
   // openLoader();
   loading.value = true;
   var request = {
    "language": GetStorage().read('lang'),
    "budget_id": id,
    "daily_filter" : day,
    "monthly_filter" : month,
    "yearly_filter" : year,
   };
  //  debugPrint(request.toString());
    var response =
        await DioClient().post(ApiLinks.getHome, request).catchError((error) async{
      if (error is BadRequestException) {
        loading.value = false;
         var apiError = json.decode(error.message!);
        Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
       // print(error.toString());
      } 
      
      if (error is UnAuthorizedException) {
        loading.value = false;
         await GetStorage().remove('user_token');
    await GetStorage().remove('groupId');
    await GetStorage().remove('userId');
    await GetStorage().remove('accountType');
    await GetStorage().remove('countryId');
    await GetStorage().remove(
      'name',
    );
    await GetStorage().remove(
      'username',
    );
    await GetStorage().remove(
      'email',
    );
    await GetStorage().remove(
      'firebase_email',
    );
    await GetStorage().remove(
      'mobile',
    );
    await GetStorage().remove(
      'photo',
    );
    await GetStorage().remove(
      'status',
    );
     Get.offAllNamed(RoutesName.LogIn);
      
      } 
      
      
      else {
        loading.value = false;
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
    if(response == null) return; 
    // debugPrint(response.toString());
    if (response['success'] == true) {
      loading.value = false;
      budgets.clear();
      expenseTypes.clear();
      // debugPrint(response.toString());
        var data = HomeData.fromJson(response);
        //print( " asasasasasas ${data.data?.budgets?.length.toString()}" );
        if(data.data != null){
          alertCount.value = data.data?.alertCount ?? 0;
          for (var budget in data.data!.budgets!) {
          budgets.add(budget);
        }
        }
        if(data.data != null){
          for (var expanse in data.data!.expenseTypes!) {
          expenseTypes.add(expanse);
        }
        }
        currency.value = data.data!.currency.toString();
        // print("gg");
        // print(selectedBudgetId+"id");
        // print(data.data!.totalInvoicesDaily.toString()+"daily");
        // print(data.data!.totalInvoicesMontly.toString()+"montly");
        // print("gg");
        totalInvoicesDaily.value = data.data!.totalInvoicesDaily.toString();
        totalInvoicesMontly.value = data.data!.totalInvoicesMontly.toString();
        totalInvoicesYearly.value = data.data!.totalInvoicesYearly.toString();
        totalExpansesDaily.value = data.data!.totalExpensesDaily.toString();
        totalExpansesMontly.value = data.data!.totalExpensesMonthly.toString();
        totalExpansesYearly.value = data.data!.totalExpensesYearly.toString();
        qrCode.value = "${GetStorage().read('mobile')}$selectedBudgetNumbder";
        // debugPrint(data.data!.totalInvoicesDaily.toString());
        // debugPrint("090999999999999999999999999999999");
        
       // return data;
    } else {
      // debugPrint('here');
    }
    return null;
  }

  Future addBudget(String name) async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    openLoader();
   
   var request = {
    "language": GetStorage().read('lang'),
    "name": name,
   };
    var response =
        await DioClient().post(ApiLinks.addBudget, request).catchError((error) {
      if (error is BadRequestException) {
        Get.back();
       
         var apiError = json.decode(error.message!);
        Get.snackbar(
          'Error'.tr,
          apiError["reason"].toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
       // print(error.toString());
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
      Get.back();
      // debugPrint(response.toString());
      getHome(null,null,null,null);
      Get.back();

    } else {
      Get.back();
      // debugPrint('here');
    }
    return null;
  }


  Future deleteBudget() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //openLoader();
   
   var request = {
    "language": GetStorage().read('lang'),
    "budget_id": selectedBudgetId.value,
   };
    var response =
        await DioClient().post(ApiLinks.budgetDelete, request).catchError((error) {
          // debugPrint(error.toString());
    //   if (error is BadRequestException) {
    //     Get.back();
       
    //      var apiError = json.decode(error.message!);
    //     Get.snackbar(
    //       'Error'.tr,
    //       apiError["reason"].toString(),
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: R.colors.themeColor,
    //     );
    //    // print(error.toString());
    //   } else {
    //     Get.back();
        
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
    }); 
    if(response == null) return;
    if (response['success'] == true) {
      //Get.back();
      //debugPrint(response.toString());
      selectedBudgetId.value = '';
      selectedBudgetIndex.value = 0;
      selectedBudgetNumbder = "".obs;
      selectedBudgetName = "".obs;
      qrCode.value = '';
      Get.back();
      getHome(null,null,null,null);
      //Get.back();

    } else {
      // Get.back();
      Get.back();
       Get.snackbar('Error'.tr, response['message']);
      // debugPrint('here');
    }
    return null;
  }

  Future resetBudget() async {
    //print("${ApiLinks.membersList}${GetStorage().read('lang')}");
    //openLoader();
   
   var request = {
    "language": GetStorage().read('lang'),
    "budget_id": selectedBudgetId.value,
   };
    var response =
        await DioClient().post(ApiLinks.resetBudget, request).catchError((error) {
          // debugPrint(error.toString());
    //   if (error is BadRequestException) {
    //     Get.back();
       
    //      var apiError = json.decode(error.message!);
    //     Get.snackbar(
    //       'Error'.tr,
    //       apiError["reason"].toString(),
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: R.colors.themeColor,
    //     );
    //    // print(error.toString());
    //   } else {
    //     Get.back();
        
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
    }); 
    // debugPrint(response.toString());
    if(response == null) return;
    if (response['success'] == true) {
      //Get.back();
      //debugPrint(response.toString());
      
      selectedBudgetId.value = '';
      selectedBudgetIndex.value = 0;
      selectedBudgetNumbder = "".obs;
      selectedBudgetName = "".obs;
      qrCode.value = '';
      Get.back();
      getHome(null,null,null,null);
      //Get.back();

    } else {
       Get.back();
       Get.snackbar('Error'.tr, response['message']);
      // debugPrint('here');
    }
    return null;
  }


}