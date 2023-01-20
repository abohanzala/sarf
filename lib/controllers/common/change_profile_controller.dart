import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as ddio;
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import 'package:sarf/controllers/common/profile_controller.dart';
import 'package:sarf/src/Auth/change_password.dart';
import '../../constant/api_links.dart';
import '../../model/moreModel/about.dart';
import '../../model/moreModel/profile.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

class ChangeProfileController extends GetxController {
  RegisterController registerController = Get.find<RegisterController>();
  ProfileController profileController = Get.find<ProfileController>();
  var message;
  bool accountType = true;
  bool isOnline = false;
  File? changeProfileImage;
  var finalSelectedCity = ''.obs;

  @override
  void onInit() {
    GetStorage().write('lang', 'en');
    super.onInit();
  }

  Future updateProfile() async {
    openLoader();
    ddio.FormData formData = ddio.FormData();

    var file = changeProfileImage;
    String fileName = file!.path.split('/').last;
    formData.files.add(MapEntry("photo",
        await ddio.MultipartFile.fromFile(file.path, filename: fileName)));

    formData.fields
        .add(MapEntry('language', GetStorage().read('lang').toString()));
    // formData.fields
    //     .add(MapEntry('email', profileController.emailController.text));
    formData.fields.add(MapEntry(
        'mobile', profileController.profileModel!.user!.mobile!.toString()));
    formData.fields.add(MapEntry(
        'account_type', accountType == true ? 0.toString() : 1.toString()));
    // formData.fields.add(MapEntry(
    //   'password',
    //   '',
    // ));
    formData.fields
        .add(MapEntry('name', profileController.nameController.text));

    formData.fields.add(MapEntry(
      'city_id',
      profileController.profileModel!.user!.userDetail!.cityId!.id.toString(),
    ));
    formData.fields.add(MapEntry(
      'expense_type_id',
      profileController.profileModel!.user!.userDetail!.expenseTypeId!.id
          .toString(),
    ));
    formData.fields.add(MapEntry(
      'insta_link',
      profileController.instaController.text,
    ));
    formData.fields.add(MapEntry(
      'twitter_link',
      profileController.twitterController.text,
    ));
    formData.fields.add(MapEntry(
      'contact_no',
      profileController.contactController.text,
    ));
    formData.fields.add(MapEntry(
      'whatsapp',
      profileController.whatsappController.text,
    ));
    formData.fields.add(MapEntry(
      'website',
      profileController.websiteController.text,
    ));
    formData.fields.add(MapEntry(
      'is_online',
      isOnline == true ? 0.toString() : 1.toString(),
    ));
    formData.fields.add(MapEntry(
      'location',
      profileController.location.value,
    ));
    formData.fields
        .add(MapEntry('location_lat', profileController.location_lat.value));
    formData.fields.add(MapEntry(
      'location_lng',
      profileController.location_lat.value,
    ));
    formData.fields.add(MapEntry('ios_device_id', 'yewuihjkfhsdjkfhdkjfhdkf'));
    formData.fields
        .add(MapEntry('android_device_id', 'yewuihjkfhsdjkfhdkjfhdkf'));
    debugPrint(formData.fields.toString());

    // var request = {
    //   'language': GetStorage().read('lang'),
    // };
    print("This is my request====================${formData.fields[3].value}");

    //DialogBoxes.openLoadingDialog();

    var response = await DioClient()
        .post(ApiLinks.change_profile, formData, true)
        .catchError((error) {
      if (error is BadRequestException) {
        Get.back();
        Get.snackbar(
          'Error',
          '${message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        print(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        debugPrint('This is error=================${error.toString()}');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      debugPrint(response.toString());
      Get.toNamed('settings');
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
      Get.back();
      Get.snackbar(
        'Error',
        '${message}',
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
