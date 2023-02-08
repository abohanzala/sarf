import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as ddio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import '../../constant/api_links.dart';
import '../../model/loginModel.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/baseview/base_controller.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class RegistrationController extends GetxController {
  var registerFormKey = GlobalKey<FormState>();
  RegisterController registerController = Get.find<RegisterController>();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  bool accountType = true;
  bool isOnline = false;
  var cityId;
  var expense_typeId;
  var message;
  var finalSelectedCity = ''.obs;
  var finalSelectedType = ''.obs;
  var location = ''.obs;
  var location_lat = ''.obs;
  var location_lng = ''.obs;
  File? profileImage;
 

  Future registration() async {
    openLoader();

    ddio.FormData formData = ddio.FormData();

    if(profileImage != null){
      var file = profileImage;
    String fileName = file!.path.split('/').last;
    formData.files.add(MapEntry("photo",
        await ddio.MultipartFile.fromFile(file.path, filename: fileName)));
    }

    

    var a = registerController.phone.text;
    final splitted = a.split('+');
    formData.fields
        .add(MapEntry('language', GetStorage().read('lang').toString()));
    formData.fields.add(MapEntry(
      'mobile',
      splitted[1],
    ));
    formData.fields.add(MapEntry(
        'account_type', accountType == true ? 0.toString() : 1.toString()));
    formData.fields.add(MapEntry(
      'password',
      registerController.password.text,
    ));
    formData.fields.add(MapEntry(
      'name',
      accountType == true
          ? companyNameController.text
          : fullNameController.text,
    ));
    formData.fields.add(MapEntry(
      'city_id',
      cityId.toString(),
    ));
    if(accountType == true){
      formData.fields.add(MapEntry(
      'expense_type_id',
      expense_typeId.toString(),
    ));
    }
    if(GetStorage().read('groupId') != null && GetStorage().read('groupId') != '' ){
      formData.fields.add(MapEntry(
      'group_id',
      GetStorage().read('groupId').toString(),
    ));
    }
    formData.fields.add(MapEntry(
      'insta_link',
      instagramController.text,
    ));
    formData.fields.add(MapEntry(
      'contact_no',
      contactController.text,
    ));
    formData.fields.add(MapEntry(
      'whatsapp',
      whatsappController.text,
    ));
    formData.fields.add(MapEntry(
      'website',
      websiteController.text,
    ));
    formData.fields.add(MapEntry(
      'is_online',
      isOnline == true ? 0.toString() : 1.toString(),
    ));
    formData.fields.add(MapEntry(
      'location',
      location.value,
    ));
    formData.fields.add(MapEntry(
      'location_lat',
      location_lat.value,
    ));
    formData.fields.add(MapEntry(
      'location_lng',
      location_lng.value,
    ));
    formData.fields.add(const MapEntry('ios_device_id', 'yewuihjkfhsdjkfhdkjfhdkf'));
    formData.fields
        .add(const MapEntry('android_device_id', 'yewuihjkfhsdjkfhdkjfhdkf'));
    debugPrint(formData.fields.toString());

    // var request = {
    //   'language': GetStorage().read('lang'),
    //   'mobile': splitted[1],
    //   'account_type': accountType == true ? 0 : 1,
    //   'password': passwordController.text,
    //   'name': accountType == true
    //       ? companyNameController.text
    //       : fullNameController.text,
    //   'city_id': cityId.toString(),
    //   'expense_type_id': expense_typeId.toString(),
    //   'insta_link': instagramController.text,
    //   'twitter_link': twitterController.text,
    //   'contact_no': contactController.text,
    //   'whatsapp': whatsappController.text,
    //   'website': websiteController.text,
    //   'is_online': isOnline == true ? 0 : 1,
    //   'location': location.value,
    //   'location_lat': location_lat.value,
    //   'location_lng': location_lng.value,
    //   'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
    //   'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
    //   'photo': ''
    // };
    // print('This is ${''}');
   // print("This is our request ==================${formData}");

    //DialogBoxes.openLoadingDialog();
     // print("${ApiLinks.registration}");
    var response = await DioClient()
        .post(ApiLinks.registration, formData, true)
        .catchError((error) {
      if (error is BadRequestException) {
        Get.snackbar(
          'Error'.tr,
          error.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        debugPrint(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        // Get.back();
      Get.snackbar(
        'Error'.tr,
        'Something went wrong'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
        debugPrint("This is error==================${error.toString()}");

        //HandlingErrors().handleError(error);
      }
    });
    //  message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response================== $response");
    if(response == null || response =="")return;
    if (response['success'] == true) {
      debugPrint(response.toString());
      registerController.password.clear();
      registerController.phone.clear();
      fullNameController.clear();
      companyNameController.clear();
      twitterController.clear();
      contactController.clear();
      websiteController.clear();
      whatsappController.clear();
      cityId = '';
      expense_typeId = '';
      location.value = '';
      location_lat.value = '';
      location_lng.value = '';
      finalSelectedType.value = 'Select Type'.tr;
      finalSelectedCity.value = 'Select City'.tr;
      var userInfo = LoginModel.fromJson(response);
      await GetStorage().write('user_token', userInfo.token);
      await GetStorage().write('userId', userInfo.user!.id);
      await GetStorage().write('name', userInfo.user!.name);
      await GetStorage().write('username', userInfo.user!.username);
      await GetStorage().write('email', userInfo.user!.email);
      await GetStorage().write('firebase_email', userInfo.user!.firebaseEmail);
      await GetStorage().write('mobile', userInfo.user!.mobile);
      await GetStorage().write('photo', userInfo.user!.photo);
      await GetStorage().write('status', userInfo.user!.status);
      await GetStorage().write('groupId', userInfo.user!.groupId);
      await createFirebaseUser();
       MyBottomNavigationController ctr =
      Get.put<MyBottomNavigationController>(MyBottomNavigationController());
  ctr.tabIndex.value = 0;
      Get.offAllNamed(RoutesName.base);
    } else {
      Get.back();
      Get.snackbar(
        'Error'.tr,
        'Something went wrong'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
    // return null;
  }

  Future createFirebaseUser() async {
    await firebase_auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: GetStorage().read('mobile') + '@gmail.com',
            password: GetStorage().read('mobile'))
        .then((value) {
      //Get.snackbar("firebase-created", 'firebase-created');
      //SnakeBars.showSuccessSnake(description: 'firebase reg');
    }).catchError((error) {
      Get.snackbar("firebase-error", error.toString());
      // SnakeBars.showErrorSnake(description: error.toString());
    });
  }
}
