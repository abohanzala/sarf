import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/auth/register_controller.dart';
import 'package:sarf/src/Auth/change_password.dart';
import '../../constant/api_links.dart';
import '../../model/moreModel/about.dart';
import '../../model/moreModel/profile.dart';
import '../../resources/resources.dart';
import '../../services/app_exceptions.dart';
import '../../services/dio_client.dart';
import '../../src/utils/routes_name.dart';
import '../../src/widgets/loader.dart';

class ProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  var location = ''.obs;
  var location_lat = ''.obs;
  var location_lng = ''.obs;
  var message;
  ProfileModel? profileModel;

  @override
  void onInit() {
    GetStorage().write('lang', 'en');
    getProfile();
    super.onInit();
  }

  Future getProfile() async {
    //check validation
    // final isValid = loginFormKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    // loginFormKey.currentState!.save();
    // validation ends
    // var a = forgotPasswordController.phone.text;
    // final splitted = a.split('+');

    var request = {
      'language': GetStorage().read('lang'),
    };
    print("This is my request====================${request}");

    //DialogBoxes.openLoadingDialog();

    var response =
        await DioClient().post(ApiLinks.profile, request).catchError((error) {
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
        debugPrint('Something went Wrong===============${error.toString()}');
        //HandlingErrors().handleError(error);
      }
    });
    message = response['message'];
    // if (response == null) return;
    debugPrint("This is my response==================$response");
    if (response['success'] == true) {
      debugPrint(response.toString());
      profileModel = ProfileModel.fromJson(response);
      print('This is ===================${profileModel}');
      nameController.text = profileModel!.user!.name == null
          ? ''
          : nameController.text = profileModel!.user!.name!;
      userNameController.text = profileModel!.user!.username == null
          ? ''
          : userNameController.text = profileModel!.user!.username!;
      emailController.text = profileModel!.user!.email == null
          ? ''
          : emailController.text = profileModel!.user!.email!;
      mobileController.text = profileModel!.user!.mobile == null
          ? ''
          : mobileController.text = profileModel!.user!.mobile!;
      instaController.text = profileModel!.user!.userDetail!.instaLink == null
          ? ''
          : profileModel!.user!.userDetail!.instaLink!;
      twitterController.text =
          profileModel!.user!.userDetail!.twitterLink == null
              ? ''
              : profileModel!.user!.userDetail!.twitterLink!;
      contactController.text = profileModel!.user!.userDetail!.contactNo == null
          ? ''
          : profileModel!.user!.userDetail!.contactNo!;
      whatsappController.text = profileModel!.user!.userDetail!.whatsapp == null
          ? ''
          : profileModel!.user!.userDetail!.whatsapp!;
      websiteController.text = profileModel!.user!.userDetail!.website == null
          ? ''
          : profileModel!.user!.userDetail!.website!;
      location.value = profileModel!.user!.userDetail!.location == null
          ? ''
          : profileModel!.user!.userDetail!.location!;
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
