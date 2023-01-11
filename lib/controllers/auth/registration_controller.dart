import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import '../../constant/api_links.dart';
import '../../model/loginModel.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

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

  @override
  void onInit() {
    GetStorage().write('lang', 'en');
    super.onInit();
  }

  Future registration() async {
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
      'mobile': registerController.phone.text,
      'account_type': accountType == true ? '0' : '1',
      'password': passwordController.text,
      'name': accountType == true
          ? companyNameController.text
          : fullNameController.text,
      'city_id': cityId.toString(),
      'expense_type_id': expense_typeId.toString(),
      'insta_link': instagramController.text,
      'twitter_link': twitterController.text,
      'contact_no': contactController.text,
      'whatsapp': whatsappController.text,
      'website': websiteController.text,
      'is_online': isOnline == true ? "0" : "1",
      'location': 'abc',
      'location_lat': '36.87655',
      'location_lng': '72.77876',
      'ios_device_id': 'yewuihjkfhsdjkfhdkjfhdkf',
      'android_device_id': 'kfhsdkjfhsdifhikfekjdjfhdk',
    };
    print("This is our request ==================${request}");

    //DialogBoxes.openLoadingDialog();

    var response = await DioClient()
        .post(ApiLinks.registration, request)
        .catchError((error) {
      if (error is BadRequestException) {
        Get.snackbar(
          'Title',
          'Message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: R.colors.themeColor,
        );
        var apiError = json.decode(error.message!);
        print(apiError.toString());

        // DialogBoxes.showErroDialog(description: apiError["reason"]);
      } else {
        Get.back();
        debugPrint('Something Went wrong');

        //HandlingErrors().handleError(error);
      }
    });
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      debugPrint(response.toString());

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
      Get.offAllNamed(RoutesName.base);

      //  await createFirebaseUser(GetStorage().read('mobile') + '@gmail.com', GetStorage().read('mobile')).then((value){
      //     SnakeBars.showSuccessSnake(description: userInfo.message);
      //     Get.offNamed(Routes.BOTTOM_NAVIGATION);
      //   }).catchError((error){
      //     SnakeBars.showErrorSnake(description: error.toString());
      //   });

    } else {
      Get.back();
      Get.snackbar(
        'Title',
        'Message',
        snackPosition: SnackPosition.TOP,
        backgroundColor: R.colors.themeColor,
      );
    }
    return null;
    // return null;
  }
}
