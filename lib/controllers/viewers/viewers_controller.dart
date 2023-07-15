import 'dart:convert';

import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:sarf/model/viewer/viewer_model.dart';
import 'package:screenshot/screenshot.dart';

import '../../constant/api_links.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/baseview/more/user_otp.dart';
import '../../src/widgets/loader.dart';

class ViewersController extends GetxController{

// TextEditingController name = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController otp = TextEditingController();
List<ScreenshotController> screenCtr = <ScreenshotController>[].obs;
Rx<ViewerModel> userData = ViewerModel().obs;
var code = "966".obs;
  var flag = "admin/country/sa.png".obs;
  var lenght = 9.obs;
  var selectedCountry = 2.obs;

  var message;

@override
  void onInit() {
    getUsers();
    super.onInit();
  }

 String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    // print("$input");
    return input;
  }

Future postNewCustomInvoice(String mobile,  String userPassword,String otpVal) async {
    openLoader();
String pass = replaceArabicNumber(userPassword);
String otpv = replaceArabicNumber(otpVal);
debugPrint(mobile);    
   var request = {
      "language": GetStorage().read('lang'),
      "mobile": mobile,
      "password": pass,
      "otp" : otpv
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
      otp.clear();
      Get.back();
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
      for (var user in userData.value.data!) {
        screenCtr.add(ScreenshotController());
      }
      //files.clear();

    } else {
      //uploadImages.clear();
      debugPrint('here');
      if(response['message'] == 'data_not_found'){
        userData.value = ViewerModel();
      }
      
    }
  }
Future register(String phoneNumber) async {
    openLoader();
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    
    var request = {
      'language': GetStorage().read('lang'),
      'mobile': phoneNumber,
    };
    debugPrint("This is my request====================$request");
    //DialogBoxes.openLoadingDialog();

    var response =
        await DioClient().post(ApiLinks.register, request).catchError((error) {
      Get.back();
      if (error is BadRequestException) {
        Get.snackbar(
          'Error'.tr,
          '$message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        debugPrint('Something went Wrong');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    debugPrint(response.toString());
    if (response['success'] == true) {
      Get.back();
      debugPrint(response.toString());
      Get.to(() => const UserOtpScreen() );
      // Get.offNamed(RoutesName.OtpScreen);
      //   userInfo = UserInfo.fromMap(response);S
      //  await  storage.write('user_token', userInfo.token);
      //  await storage.write('userId', userInfo.user!.id);
      //  await storage.write('name', userInfo.user!.name);
      //  await storage.write('username', userInfo.user!.username);
      //  await storage.write('email', userInfo.user!.email);
      //  await storage.write('firebase_email', userInfo.user!.firebaseEmail);
      //  await storage.write('mobile', userInfo.user!.mobile);
      //  await storage.write('photo', userInfo.user!.photo);
      //  await storage.write('status', userInfo.user!.status);
      //   Navigator.of(Get.context!).pop();

      //  await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com', GetStorage().read('mobile')).then((value){
      //     SnakeBars.showSuccessSnake(description: userInfo.message);
      //     Get.offNamed(Routes.BOTTOM_NAVIGATION);
      //   }).catchError((error){
      //     SnakeBars.showErrorSnake(description: error.toString());
      //   });

    } else {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        message.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
    // return null;
  }

}