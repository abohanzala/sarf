import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constant/api_links.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';

class LoginController extends GetxController{
var loginFormKey = GlobalKey<FormState>();  
TextEditingController phone = TextEditingController();
TextEditingController password = TextEditingController();

@override
void onInit(){
  GetStorage().write('lang', 'en');
  super.onInit();


}

  Future login() async {
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    
    var request = {
      'language': GetStorage().read('lang'),
      'id_number_iqama': phone.text,
      'password': password.text,
      'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
      'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
    };
    
    //DialogBoxes.openLoadingDialog();
    
    var response =
        await DioClient().post(ApiLinks.loginUser, request).catchError((error) {
          
      if (error is BadRequestException) {
        
        var apiError = json.decode(error.message!);
        
       // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        debugPrint('Something went Wrong');
        //HandlingErrors().handleError(error);
      }
    });
    // if (response == null) return;
    debugPrint("aaaaaaaaaaaa$response");
    if (response['success'] == true) {
      debugPrint(response.toString());
    //   userInfo = UserInfo.fromMap(response);
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
      // SnakeBars.showErrorSnake(description: response['message']);
      // Navigator.of(Get.context!).pop();
    }
    return null;
    // return null;
  }

}