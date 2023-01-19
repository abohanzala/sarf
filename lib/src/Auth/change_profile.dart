import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/auth/change_password_controller.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/auth/data_collection_controller.dart';
import '../../controllers/common/about_controller.dart';
import '../../controllers/common/change_profile_controller.dart';
import '../../controllers/common/profile_controller.dart';
import '../../resources/resources.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/loader.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  ProfileController profileController = Get.find<ProfileController>();
  DataCollectionController dataCollectionController =
      Get.find<DataCollectionController>();
  int selectedCityIndex = -1;
  ChangeProfileController changeProfileController =
      Get.find<ChangeProfileController>();
  XFile? _imageFile;
  VideoPlayerController? _controller;
  bool isVideo = false;
  String? _retrieveDataError;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    getData();
    getDataCollection();

    print("initState Called");
  }

  Future getData() async {
    await profileController.getProfile();
  }

  Future getDataCollection() async {
    await dataCollectionController.dataCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Color(0xFFF2F2F9),
            body: Stack(
              children: [
                buildBackGroundImage(),
                buildBackArrowContainerAndChangeProfileText(),
              ],
            ),
          ),
          buildProfileCard()
        ],
      ),
    );
  }

  Widget buildBackGroundImage() {
    return Stack(alignment: Alignment.topLeft, children: [
      Image.asset(
        R.images.backgroundImageChangePassword,
        width: MediaQuery.of(context).size.width,
      ),
      buildBackArrowContainerAndChangeProfileText(),
    ]);
  }

  Widget buildBackArrowContainerAndChangeProfileText() {
    return Positioned(
      top: 50,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(R.images.arrowBlue)),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Change Profile'.tr,
              style: TextStyle(
                  color: R.colors.white, fontFamily: 'bold', fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    return Positioned(
      top: 100,
      right: 20,
      left: 20,
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                buildNameField(),
                buildSelectCityDropDown(),
                buildUserNameField(),
                buildWhatsappField(),
                buildTwitterField(),
                buildInstaField(),
                buildContactNoField(),
                buildEmailField(),
                buildLocationButton(),
                buildUploadImage(),
                buildUpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context,
      bool isMultiImage = false,
      required bool isCamera}) async {
    if (_controller != null) {
      log('this is video function');
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      log('this is video function');
      //_pickVideo(isCamera);
      // final XFile? file = await _picker.pickVideo(
      //     source: source, maxDuration: const Duration(seconds: 10));

      // setState(() {
      //   _videoList = file;
      // });

      // final uint8list = await VideoThumbnail.thumbnailData(
      //   video: file!.path.toString(),
      //   imageFormat: ImageFormat.JPEG,
      //   maxWidth:
      //       128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      //   quality: 25,
      // );
      //
      // debugPrint(uint8list.toString());
      // //   await _playVideo(file);

    } else if (isMultiImage) {
      log('this is my gallery images');
      // await _displayPickImageDialog(context!,
      //         (double? maxWidth, double? maxHeight, int? quality) async {
      //       try {
      //         final List<XFile> pickedFileList = await _picker.pickMultiImage(
      //           maxWidth: maxWidth,
      //           maxHeight: maxHeight,
      //           imageQuality: quality,
      //         );
      //
      //         setState(() {
      //           if (_imageFile != null) {
      //             _imageFile = pickedFileList.first;
      //           }
      //         });
      //       } catch (e) {
      //         setState(() {
      //           _pickImageError = e;
      //         });
      //       }
      //    });
    } else {
      print('singleImage///////');
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _imageFile = pickedFile!;
          changeProfileController.changeProfileImage = File(_imageFile!.path);
          print(changeProfileController.changeProfileImage);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  void openGalleryCameraPickDialogs(bool video) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                  child: Container(
                    height: 145,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'medium',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            'Select the source',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF999999),
                              fontFamily: 'medium',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                _onImageButtonPressed(ImageSource.camera,
                                    context: context,
                                    isMultiImage: false,
                                    isCamera: true);
                                setState(() {});
                              },
                              child: Container(
                                height: 32,
                                width: 105,
                                decoration: BoxDecoration(
                                  color: R.colors.buttonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'camera',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);

                                _onImageButtonPressed(ImageSource.gallery,
                                    context: context,
                                    isMultiImage: false,
                                    isCamera: false);
                                setState(() {});
                              },
                              child: Container(
                                height: 32,
                                width: 105,
                                decoration: BoxDecoration(
                                  color: R.colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    'gallery',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildUploadImage() {
    return InkWell(
      onTap: () {
        openGalleryCameraPickDialogs(false);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                color: profileController.profileModel!.user!.photo != null
                    ? R.colors.transparent
                    : R.colors.blue),
            child: changeProfileController.changeProfileImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File(
                        _imageFile!.path,
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : profileController.profileModel!.user!.photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          ApiLinks.assetBasePath +
                              profileController.profileModel!.user!.photo!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          'LOGO',
                          style: TextStyle(
                              fontFamily: 'regular',
                              color: Colors.white,
                              fontSize: 12),
                        ),
                      )),
      ),
    );
  }

  Widget buildLocationButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          //   Get.toNamed(RoutesName.RegistrationDetails);
        },
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.pin_drop,
                  size: 20,
                  color: Colors.blue,
                )),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Text(
                      profileController.locationController.text.tr,
                      style: TextStyle(
                          color: R.colors.black,
                          fontSize: 13,
                          fontFamily: 'medium'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSelectCityDropDown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openPopUpOptionsForCities();
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                GetStorage().read('lang') == 'en'
                    ? profileController
                        .profileModel!.user!.userDetail!.cityId!.name!.en
                        .toString()
                    : profileController
                        .profileModel!.user!.userDetail!.cityId!.name!.ar
                        .toString(),
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.black),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpdateButton() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      child: customButton(
          margin: 20,
          width: MediaQuery.of(context).size.width,
          titleTextAlign: TextAlign.center,
          onPress: (() {
            changeProfileController.updateProfile();
            //Get.toNamed('otp_screen');
          }),
          title: 'Update'.tr,
          color: R.colors.buttonColor,
          height: 45,
          borderColour: R.colors.transparent,
          textColor: R.colors.white),
    );
  }

  Widget buildNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Full Name *',
          controller: profileController.nameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildUserNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'bdscdscb',
          controller: profileController.userNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildEmailField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '213412',
          controller: profileController.emailController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildInstaField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@d cn',
          controller: profileController.instaController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWhatsappField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@dscd',
          controller: profileController.whatsappController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildWebsiteField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@dsjnc',
          controller: profileController.websiteController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildContactNoField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '+923313',
          controller: profileController.contactController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildTwitterField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: '@adcsdc',
          controller: profileController.twitterController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildLocationField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'e.g oloasjxdjdn dhx',
          controller: profileController.locationController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  void openPopUpOptionsForCities() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        //  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Select City',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'bold',
                                  color: R.colors.buttonColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                //  height: MediaQuery.of(context).size.height / 4,
                                color: R.colors.lightGrey,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        dataCollectionController.cities!.length,
                                    itemBuilder: (BuildContext, index) {
                                      return InkWell(
                                        onTap: () {
                                          selectedCityIndex = index;
                                          print(selectedCityIndex);
                                          setState(() {});
                                          var getCityId =
                                              dataCollectionController
                                                  .cities![selectedCityIndex]
                                                  .id;

                                          print(
                                              "This is my selctedCity Id ============${getCityId}");

                                          setState(() {});

                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color:
                                                    selectedCityIndex == index
                                                        ? R.colors.buttonColor
                                                        : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            margin: EdgeInsets.only(top: 2),
                                            child: Center(
                                              child: Text(
                                                dataCollectionController
                                                    .cities![index].name!.en
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: R.colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }
}
