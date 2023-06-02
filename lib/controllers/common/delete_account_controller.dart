import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import 'package:sarf/src/Auth/change_password.dart';
import '../../constant/api_links.dart';
import '../../model/moreModel/about.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

class DeleteAccountController extends GetxController {
  var message;
  TextEditingController reasonForDeletingAccountController =
      TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    // GetStorage().write('lang', 'en');
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

  Future deleteAccount() async {
    openLoader();
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    // var a = forgotPasswordController.phone.text;
    // final splitted = a.split('+');
    String pass = replaceArabicNumber(passwordController.text);
    var request = {
      'language': GetStorage().read('lang'),
      'reason': reasonForDeletingAccountController.text,
      'password': pass,
    };
    print("This is my request====================${request}");

    //DialogBoxes.openLoadingDialog();

    var response = await DioClient()
        .post(ApiLinks.delete_account, request)
        .catchError((error) {
      if (error is BadRequestException) {
        Get.back();
        Get.snackbar(
          'Error'.tr,
          '${message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        print(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        debugPrint("This is error=================${error.toString()}");
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      Get.back();
      debugPrint(response.toString());
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
      Get.offAllNamed(RoutesName.deleteAccount3);
      update();
      //   Get.toNamed(RoutesName.RegistrationDetails);
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
      Get.snackbar(
        'Error'.tr,
        '$message',
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
      // SnakeBars.showErrorSnake(description: response['message']);
      // Navigator.of(Get.context!).pop();
    }
    return null;
    // return null;
  }
}
