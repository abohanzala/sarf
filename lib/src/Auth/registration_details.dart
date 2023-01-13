import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sarf/resources/images.dart';
import 'package:sarf/src/Auth/registration.dart';
import 'package:sarf/src/utils/routes_name.dart';
import 'package:sarf/src/widgets/custom_textfield.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/auth/data_collection_controller.dart';
import '../../controllers/auth/register_controller.dart';
import '../../controllers/auth/registration_controller.dart';
import '../../helper/aspect_ratio.dart';
import '../../resources/resources.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);

  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {
  DataCollectionController dataCollectionController =
      Get.find<DataCollectionController>();

  RegistrationController registrationController =
      Get.find<RegistrationController>();
  FocusNode searchFieldNode = FocusNode();
  bool business = true;
  bool personal = false;
  bool onlineBusiness = true;
  bool offlineBusiness = false;
  bool checkBox = false;
  bool citySelected = false;
  int selectedCityIndex = -1;
  int selectedTypeIndex = -1;
  String finalSelectedCity = '';
  XFile? _imageFileList;
  String? _retrieveDataError;
  dynamic _pickImageError;
  bool isVideo = false;
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

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
                                  color: Color(0xFF22A754),
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
                                  color: Color(0xFF22A754),
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
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile> pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );

          setState(() {
            if (_imageFileList != null) {
              _imageFileList = pickedFileList.first;
            }
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      print('singleImage///////');
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            print('SetStateCalling======================================');
            _imageFileList = pickedFile!;
            print(
                "This is my ImagePath=====================${_imageFileList!.length}");
            //    _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  //
  // void _setImageFileListFromFile(XFile? value) {
  //   _imageFileList = value == null ? null : <XFile>[value];
  // }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await dataCollectionController.dataCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color(0xFFF2F2F9),
            body: Stack(
              children: [
                buildBackGroundImage(),
                buildBackArrowContainer(),
              ],
            ),
          ),
          buildRegistrationDetailsCard()
        ],
      ),
    );
  }

  buildBackGroundImage() {
    return Image.asset(
      'assets/images/backgroundImage.png',
      width: MediaQuery.of(context).size.width,
    );
  }

  buildBackArrowContainer() {
    return Positioned(
      top: 50,
      left: 30,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Color(0xFFFFFFFF)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/arrow.png'),
          ),
        ),
      ),
    );
  }

  buildRegistrationDetailsCard() {
    return Positioned(
      top: 230,
      child: Container(
        height: MediaQuery.of(context).size.height - 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            children: [buildRegistrationDetailsText(), buildForm()],
          ),
        ),
      ),
    );
  }

  Widget buildRegistrationDetailsText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          'Registration Details'.tr,
          style:
              TextStyle(color: R.colors.grey, fontFamily: 'bold', fontSize: 18),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Column(
        children: [
          buildUserTypeText(),
          buildUserTypeOptions(),
          buildPasswordField(),
          business ? buildCompanyNameField() : buildFullNameField(),
          buildSelectCityDropDown(),
          buildTypeDropDown(),
          business ? buildInstagramField() : Container(),
          business ? buildTwitterField() : Container(),
          business ? buildContactNoField() : Container(),
          business ? buildWhatsappField() : Container(),
          business ? buildBusinessTypeText() : Container(),
          business ? buildBusinessTypeOptions() : Container(),
          business && onlineBusiness ? buildWebsiteField() : Container(),
          offlineBusiness ? buildLocationButton() : Container(),
          business ? buildUploadImage() : Container(),
          buildAgreeToTermsAndConditionsBox(),
          buildSubmitButton()
        ],
      ),
    );
  }

  buildAgreeToTermsAndConditionsBox() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          Checkbox(
            checkColor: Colors.white,
            activeColor: Color(0xFF2C313E),
            value: this.checkBox,
            onChanged: (bool? value) {
              setState(() {
                this.checkBox = value!;
              });
            },
          ),
          Text(
            'I Accept'.tr,
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              ' Terms & Conditions'.tr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
          ),
        ], //<Widget>[]
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFEAEEF2)),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, right: 10, top: 3),
              child: Image.asset('assets/images/passwordIcon.png',
                  height: 15, color: Color(0xFF9A9A9A).withOpacity(0.8))),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required Field".tr;
                }
                return null;
              },
              controller: registrationController.passwordController,
              focusNode: searchFieldNode,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Password'.tr,
                  hintStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'medium',
                      color: Color(0xFF9A9A9A).withOpacity(0.8)),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  Widget buildUploadImage() {
    return InkWell(
      onTap: () {
        //b    print('Image Path============${_imageFileList!.path}');
        openGalleryCameraPickDialogs(false);
      },
      child: Column(
        children: [
          _imageFileList != null
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File(
                        _imageFileList!.path,
                      ),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      color: R.colors.grey),
                  child: Center(
                    child: Text(
                      'Upload Image'.tr,
                      style: TextStyle(
                          fontFamily: 'regular',
                          color: Colors.white,
                          fontSize: 10),
                    ),
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '(Optional)'.tr,
              style: TextStyle(
                  fontFamily: 'regular', color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFB7B57),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (registrationController.passwordController.text.isEmpty) {
            Get.snackbar(
              'Alert',
              'Enter Password',
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
            return;
          }
          if (registrationController.accountType == true) {
            if (registrationController.companyNameController.text.isEmpty) {
              Get.snackbar(
                'Alert',
                'Please Enter Name',
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            }
          }
          if (registrationController.accountType == false) {
            if (registrationController.fullNameController.text.isEmpty) {
              print(
                  "This is fullName =============${registrationController.fullNameController.text}");
              Get.snackbar(
                'Alert',
                'Please Enter Name',
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            }
          }
          if (selectedCityIndex == -1) {
            Get.snackbar(
              'Alert',
              'Please Select City',
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
            return;
          }
          if (selectedTypeIndex == -1) {
            Get.snackbar(
              'Alert',
              'Please Select Type',
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
            return;
          }
          if (checkBox == false) {
            Get.snackbar(
              'Alert',
              'Please Agree to Terms And Conditions',
              snackPosition: SnackPosition.TOP,
              backgroundColor: R.colors.themeColor,
            );
            return;
          }
          if (registrationController.accountType == true) {
            if (registrationController.companyNameController.text.isEmpty) {
              Get.snackbar(
                'Alert',
                'Please Enter Name',
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            }
          }
          if (registrationController.accountType == false) {
            print(
                "This is fullName =============${registrationController.fullNameController.text}");
            if (registrationController.fullNameController.text.isEmpty) {
              print(
                  "This is fullName =============${registrationController.fullNameController.text}");
              Get.snackbar(
                'Alert',
                'Please Enter Name',
                snackPosition: SnackPosition.TOP,
                backgroundColor: R.colors.themeColor,
              );
              return;
            }
          }
          registrationController.registration();
        },
        child: Center(
          child: Text(
            'Submit'.tr,
            style: TextStyle(
                color: Colors.white, fontSize: 13, fontFamily: 'medium'),
          ),
        ),
      ),
    );
  }

  Widget buildUserTypeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text(
            'User Type'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Business'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildOnlineBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Online'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildOfflineBusinessText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            'Offline'.tr,
            style: TextStyle(
                color: R.colors.grey, fontSize: 12, fontFamily: 'medium'),
          )
        ],
      ),
    );
  }

  Widget buildBusinessTypeOptions() {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      child: Row(
        children: [buildOnlineBusinessButton(), buildOfflineBusinessButton()],
      ),
    );
  }

  Widget buildOnlineBusinessButton() {
    return InkWell(
      onTap: () {
        onlineBusiness = true;
        offlineBusiness = false;
        registrationController.isOnline = true;
        setState(() {});
      },
      child: Container(
        //   margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: onlineBusiness
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildOnlineBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildOfflineBusinessButton() {
    return InkWell(
      onTap: () {
        onlineBusiness = false;
        offlineBusiness = true;
        registrationController.isOnline = false;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: offlineBusiness
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildOfflineBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildUserTypeOptions() {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      child: Row(
        children: [buildBusinessButton(), buildPersonalButton()],
      ),
    );
  }

  Widget buildBusinessButton() {
    return InkWell(
      onTap: () {
        business = true;
        personal = false;
        registrationController.accountType = true;
        setState(() {});
      },
      child: Container(
        //   margin: EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: business
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildBusinessText(),
          ],
        ),
      ),
    );
  }

  Widget buildPersonalText() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        'Personal'.tr,
        style: TextStyle(
            fontSize: 14, fontFamily: 'regular', color: Color(0xFF9A9A9A)),
      ),
    );
  }

  Widget buildBusinessTypeText() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text(
            'Business'.tr,
            style: TextStyle(
                fontSize: 14, fontFamily: 'regular', color: Color(0xFF9A9A9A)),
          ),
        ],
      ),
    );
  }

  Widget buildPersonalButton() {
    return InkWell(
      onTap: () {
        business = false;
        personal = true;
        registrationController.accountType = false;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    borderRadius: BorderRadius.circular(100),
                    color: R.colors.transparent),
                height: 20,
                width: 20,
                child: personal
                    ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: R.colors.black),
                        ),
                      )
                    : Container()),
            buildPersonalText(),
          ],
        ),
      ),
    );
  }

  Widget buildCompanyNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          makeCompulsoryField: true,
          hintTextSize: 12,
          hintText: 'Company Name'.tr,
          controller: registrationController.companyNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildFullNameField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Full Name'.tr,
          controller: registrationController.fullNameController,
          color: R.colors.lightGrey,
          height: 45,
          borderColour: R.colors.transparent),
    );
  }

  Widget buildInstagramField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: customTextField(
          hintTextSize: 12,
          hintText: 'Instagram Link (Optional)'.tr,
          controller: registrationController.instagramController,
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
          hintText: 'Website (Optional)'.tr,
          controller: registrationController.websiteController,
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
          hintText: 'Contact No (Optional)',
          controller: registrationController.contactController,
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
          hintText: 'Whatsapp (Optional)',
          controller: registrationController.whatsappController,
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
          hintText: 'Twitter Link (Optional)'.tr,
          controller: registrationController.twitterController,
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
                                          finalSelectedCity =
                                              dataCollectionController
                                                  .cities![selectedCityIndex]
                                                  .name
                                                  .toString();
                                          var cityId = dataCollectionController
                                              .cities![selectedCityIndex].id
                                              .toString();
                                          print(finalSelectedCity.tr);
                                          print(
                                              "This is my selctedCity Id ============${cityId}");

                                          setState(() {
                                            registrationController.cityId =
                                                cityId;
                                          });
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

  void openPopUpOptionsForTypes() {
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
                            'Select Type',
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
                                      dataCollectionController.types!.length,
                                  itemBuilder: (BuildContext, index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedTypeIndex = index;
                                        print(selectedTypeIndex);

                                        var typeId = dataCollectionController
                                            .types![index].id
                                            .toString();
                                        print(finalSelectedCity.tr);
                                        print(
                                            "This is my typeCity Id ============${typeId}");

                                        setState(() {
                                          registrationController
                                              .expense_typeId = typeId;
                                        });
                                        Get.back();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: selectedTypeIndex == index
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
                                                  .types![index].expenseName
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
            ),
          );
        });
      },
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
                'Select City'.tr,
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.grey),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeDropDown() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 45,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          openPopUpOptionsForTypes();
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                'Type'.tr,
                style: TextStyle(
                    fontSize: 12, fontFamily: 'medium', color: R.colors.grey),
              )),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLocationButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 50,
      decoration: BoxDecoration(
        color: R.colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          //   Get.toNamed(RoutesName.RegistrationDetails);
        },
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.pin_drop,
                  size: 20,
                  color: Colors.white,
                )),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Location'.tr,
                style: TextStyle(
                    color: Colors.white, fontSize: 13, fontFamily: 'medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}
