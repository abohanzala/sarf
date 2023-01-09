import 'package:get/get.dart';

import '../../services/dio_client.dart';

class LoginController extends GetxController{
  

//   Future login() async {
//     //check validation
//     // final isValid = loginFormKey.currentState!.validate();
//     // if (!isValid) {
//     //   return;
//     // }
//     // loginFormKey.currentState!.save();
//     // validation ends
    
//     var request = {
//       'language': storage.read('lang'),
//       'username': usernameCtrl.text,
//       'password': passCtrl.text,
//       'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
//       'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
//     };
    
//     //DialogBoxes.openLoadingDialog();
    
//     var response =
//         await DioClient().post(ApiLinks.loginApi, request).catchError((error) {
          
//       if (error is BadRequestException) {
        
//         var apiError = json.decode(error.message!);
        
//         DialogBoxes.showErroDialog(description: apiError["reason"]);
//       } else {
       
//         HandlingErrors().handleError(error);
//       }
//     });
//     // if (response == null) return;
//     debugPrint("aaaaaaaaaaaa$response");
//     if (response['success'] == true) {
      
//       userInfo = UserInfo.fromMap(response);
//      await  storage.write('user_token', userInfo.token);
//      await storage.write('userId', userInfo.user!.id);
//      await storage.write('name', userInfo.user!.name);
//      await storage.write('username', userInfo.user!.username);
//      await storage.write('email', userInfo.user!.email);
//      await storage.write('firebase_email', userInfo.user!.firebaseEmail);
//      await storage.write('mobile', userInfo.user!.mobile);
//      await storage.write('photo', userInfo.user!.photo);
//      await storage.write('status', userInfo.user!.status);
//       Navigator.of(Get.context!).pop();
      
//      await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com', GetStorage().read('mobile')).then((value){
//         SnakeBars.showSuccessSnake(description: userInfo.message);
//         Get.offNamed(Routes.BOTTOM_NAVIGATION);
//       }).catchError((error){
//         SnakeBars.showErrorSnake(description: error.toString());
//       });
      
//     } else {
//       SnakeBars.showErrorSnake(description: response['message']);
//       Navigator.of(Get.context!).pop();
//     }
//     return null;
//     // return null;
//   }

}