import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarf/controllers/support/support_controller.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class NewSupportScreen extends StatefulWidget {
  const NewSupportScreen({super.key});

  @override
  State<NewSupportScreen> createState() => _NewSupportScreenState();
}

class _NewSupportScreenState extends State<NewSupportScreen> {
  SupportController ctr = Get.find<SupportController>();
  //TextEditingController txt = TextEditingController();

  @override
  void initState() {
    
    ctr.txt.clear();
    ctr.selectedTypeId.value = '';
     ctr.selectedTypeIndex.value = 0;
      ctr.selectedTypeName.value = '';
      ctr.uploadImages.clear();
    super.initState();
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage == null) return;

      ctr.uploadImages.add(File(pickedImage.path));
      // setState(() {
      //   image = File(pickedImage.path);
      // });

    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            customAppBar('Add New Support'.tr, true, false, '', false),
            //appbarSearch(),
            //const SizedBox(height: 10,),
            Transform(
              transform: Matrix4.translationValues(0, -10, 0),
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: R.colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 45,
                      decoration: BoxDecoration(
                        color: R.colors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            //openPopUpOptions('No Types Available');
                            Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: R.colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                padding: const EdgeInsets.all(10),
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      var singleSupportType =
                                          ctr.supportTypes[index];
                                      //print(singleSupportType.name?.en);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: R.colors.white,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: GestureDetector(
                                            onTap: () {
                                              ctr.selectedTypeName.value =
                                                  GetStorage()
                                                              .read("lang") ==
                                                          'en'
                                                      ? singleSupportType
                                                              .name?.en ??
                                                          ""
                                                      : singleSupportType
                                                              .name?.ar ??
                                                          "";
                                              ctr.selectedTypeId.value =
                                                  singleSupportType.id
                                                      .toString();
                                              ctr.selectedTypeIndex.value =
                                                  index + 1;
                                              Get.back();
                                            },
                                            child: Obx(
                                              () => Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      color: R.colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: R.colors.black,
                                                          width: 1),
                                                    ),
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ctr.selectedTypeIndex
                                                                        .value -
                                                                    1 ==
                                                                index
                                                            ? R.colors
                                                                .themeColor
                                                            : R.colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    GetStorage().read("lang") ==
                                                            'en'
                                                        ? singleSupportType
                                                                .name?.en ??
                                                            ""
                                                        : singleSupportType
                                                                .name?.ar ??
                                                            "",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: R.colors.lightBlue4,
                                        thickness: 0.2,
                                      );
                                    },
                                    itemCount: ctr.supportTypes.length),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    ctr.selectedTypeName.value != ''
                                        ? ctr.selectedTypeName.value
                                        : "Select type".tr,
                                    style: TextStyle(
                                        fontSize: 14, color: ctr.selectedTypeName.value != '' ? R.colors.black : R.colors.grey),
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.lightGrey),
                      child: TextFormField(
                        
                        maxLines: 10,
                        controller: ctr.txt,
                        decoration: InputDecoration(
                          hintText: 'Message here'.tr,
                          hintStyle: TextStyle(color: R.colors.grey),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: R.colors.blue,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.camera);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: R.colors.lightBlue,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: R.colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Camera'.tr,
                                  style: TextStyle(
                                      fontSize: 14, color: R.colors.white),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              pickImage(ImageSource.gallery);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: R.colors.lightBlue,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.camera,
                                    color: R.colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Gallery'.tr,
                                  style: TextStyle(
                                      fontSize: 14, color: R.colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => ctr.uploadImages.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              height: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: ctr.uploadImages.length,
                                        itemBuilder: (context, index) {
                                          var singleImage =
                                              ctr.uploadImages[index];
                                          return Stack(
                                            //alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                margin: const EdgeInsets.only(
                                                    right: 10, top: 5),
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  // image: DecorationImage(image: Image.file(singleImage.path) ,fit: BoxFit.cover),
                                                  //color: R.colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    singleImage,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 5,
                                                right: 10,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    ctr.uploadImages
                                                        .removeAt(index);
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    //padding: const EdgeInsets.all(5),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape
                                                                .circle),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 12,
                                                        color: R.colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        if (ctr.selectedTypeName.value == '') {
                          Get.snackbar('Error'.tr, 'Select Type'.tr);
                          return;
                        }
                        if (ctr.txt.text.isEmpty) {
                          Get.snackbar('Error'.tr, 'Message required'.tr);
                          return;
                        }
                        if (ctr.uploadImages.isEmpty) {
                          Get.snackbar('Error'.tr, 'Image required'.tr);
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        ctr.postNewSupport(ctr.txt.text);
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: R.colors.themeColor),
                        child: Center(
                            child: Text(
                          'Submit'.tr,
                          style: TextStyle(color: R.colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
