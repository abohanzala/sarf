import 'dart:io';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarf/controllers/members/members_controller.dart';
import 'package:sarf/src/baseview/Invoices/fullscreen_img.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constant/api_links.dart';
import '../../../controllers/home/home_controller.dart';
import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class InvoiceDetails extends StatefulWidget {
  final String id;
  final String invoiceNum;
  final bool reverse;
  final bool isHome;
  const InvoiceDetails(
      {super.key,
      required this.id,
      required this.invoiceNum,
      required this.reverse,
      required this.isHome});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  MembersController ctr = Get.put<MembersController>(MembersController());
  final ScreenshotController screenshotController = ScreenshotController();
  File? _scannedImage;

  Future pickImage(ImageSource source) async {
    try {
      var pickedFile = await ImagePicker().pickMultiImage(imageQuality: 35);
      // var pickedFile = await picker.pickImage(source: source, imageQuality: 35);
      // ignore: unnecessary_null_comparison
      if (pickedFile == null) return;
      for (var item in pickedFile) {
        ctr.uploadImages.add(File(item.path));
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  void _startScan(BuildContext context) async {
    try {
      var image =
          await CunningDocumentScanner.getPictures().catchError((error) {
        Get.snackbar("Error".tr, error.toString(),
            backgroundColor: R.colors.blue);
        return error;
      });

      if (image != null) {
        for (var img in image) {
          _scannedImage = File(img);
          ctr.uploadImages.add(_scannedImage!);
        }

        setState(() {});
      }
    } on PlatformException catch (e) {
      print("hereeeeee");
      Get.snackbar("Error".tr, e.toString());
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    ctr.getInvoiceDetail(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(GetStorage().read("user_token"));
    return Scaffold(
        backgroundColor: R.colors.lightGrey,
        body:
            Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customAppBar('Invoice'.tr, true, false, '', true,
                          () async {
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        screenshotController
                            .capture()
                            .then((Uint8List? image) async {
                          if (image != null) {
                            try {
                              String fileName = DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString();
                              final imagePath =
                                  await File('$directory/$fileName.png')
                                      .create();
                              await imagePath.writeAsBytes(image);

//           final pdf = pw.Document();

//           final pdfImage = pw.MemoryImage(
//   File(imagePath.path).readAsBytesSync(),
// );

// pdf.addPage(pw.Page(
//   pageFormat: PdfPageFormat.a4,
//   build: (pw.Context context) {
//   return pw.Center(
//     child: pw.Image(pdfImage),
//   ); // Center
// })); // Page

//    final output = await getTemporaryDirectory();
//    String fileName2 = DateTime.now().microsecondsSinceEpoch.toString();
//    final file = File("${output.path}/$fileName2.pdf");
// // final file = File("example.pdf");
// await file.writeAsBytes(await pdf.save());

                              // final file = File("example.pdf");
                              // await file.writeAsBytes(await pdf.save());
                              // ignore: deprecated_member_use
                              Share.shareXFiles([XFile(imagePath.path)]);
                            } catch (error) {
                              debugPrint(error.toString());
                            }
                          }
                        }).catchError((onError) {
                          debugPrint('Error --->> $onError');
                        });
                      }),
                      //appbarSearch(),
                      //const SizedBox(height: 10,),
                      if (ctr.loadingInvoiceDetails.value == true)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SizedBox(),
                          // Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),),
                        ),
                      if (ctr.loadingInvoiceDetails.value == false &&
                          ctr.inVoiceDetails.value.data == null)
                        Center(
                          child: Text(
                            'No Data'.tr,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      if (ctr.inVoiceDetails.value.data != null) ...[
                        Transform(
                          transform: Matrix4.translationValues(0, -10, 0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    kIsWeb == true ? Get.width * 0.11 : 0),
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: R.colors.white,
                              ),
                              child: Screenshot(
                                controller: screenshotController,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  color: R.colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: budgetName(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Invoice No'.tr,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            ctr.inVoiceDetails.value.data!
                                                .createdDate!,
                                            style: TextStyle(
                                                color: R.colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.invoiceNum,
                                        style: TextStyle(
                                            color: R.colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Customer Name'.tr,
                                        style: TextStyle(
                                            color: R.colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ctr.inVoiceDetails.value.data!.customer!
                                            .name!,
                                        style: TextStyle(
                                            color: R.colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        // "Receiver Name".tr,
                                        widget.isHome == true
                                            ? 'Receiver'.tr
                                            : "Receiver Name".tr,
                                        style: TextStyle(
                                            color: R.colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        widget.isHome == true
                                            ? Get.find<HomeController>()
                                                .selectedBudgetName
                                                .value
                                            : ctr.inVoiceDetails.value.data!
                                                .user!.name!,
                                        style: TextStyle(
                                            color: R.colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Description'.tr,
                                        style: TextStyle(
                                            color: R.colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ctr.inVoiceDetails.value.data!.note ??
                                            '',
                                        style: TextStyle(
                                            color: R.colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: R.colors.lightGrey,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'AMOUNT'.tr,
                                              style: TextStyle(
                                                  color: R.colors.themeColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              ctr.inVoiceDetails.value.data!
                                                  .amount
                                                  .toString(),
                                              style: TextStyle(
                                                  color: R.colors.themeColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: Obx(() => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kIsWeb == true
                                            ? Get.width * 0.11
                                            : 0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Text(
                                              GetStorage()
                                                          .read("userId")
                                                          .toString() ==
                                                      ctr.inVoiceDetails.value
                                                          .data?.userId
                                                          .toString()
                                                  ? 'Sent Attachments'.tr
                                                  : 'Received Attachments'.tr,
                                              style: TextStyle(
                                                  color: R.colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Container(
                                              width: Get.width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                              height: 80,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: ctr
                                                            .inVoiceDetails
                                                            .value
                                                            .data
                                                            ?.attachments
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var singleAttach = ctr
                                                                  .inVoiceDetails
                                                                  .value
                                                                  .data
                                                                  ?.attachments?[
                                                              index];
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              Get.to(() => FullScreenView(
                                                                  url:
                                                                      "${ApiLinks.assetBasePath}$singleAttach",
                                                                  tag:
                                                                      "${ApiLinks.assetBasePath}$singleAttach",
                                                                  singleAttach:
                                                                      singleAttach!));
                                                            },
                                                            child: Hero(
                                                              tag:
                                                                  "${ApiLinks.assetBasePath}$singleAttach",
                                                              child: Container(
                                                                width: 60,
                                                                height: 60,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        top: 5),
                                                                //padding: const EdgeInsets.all(8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: R
                                                                      .colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child: Image
                                                                            .network(
                                                                          "${ApiLinks.assetBasePath}$singleAttach",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Center(child: Text('No Data'.tr));
                                                                          },
                                                                        )),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //  Container(
                                            //   width: 60,
                                            //   height: 60,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(8),
                                            //     color: R.colors.grey
                                            //      ),
                                            //  ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Divider(
                                              color: R.colors.lightBlue4,
                                              thickness: 0.1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          if (ctr.inVoiceDetails.value.data
                                                  ?.invoiceFiles?.isNotEmpty ==
                                              true)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Text(
                                                GetStorage()
                                                            .read("userId")
                                                            .toString() ==
                                                        ctr.inVoiceDetails.value
                                                            .data?.userId
                                                            .toString()
                                                    ? 'Received Attachments'.tr
                                                    : 'Sent Attachments'.tr,
                                                style: TextStyle(
                                                    color: R.colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Container(
                                              width: Get.width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0),
                                              height: 80,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: ctr
                                                            .inVoiceDetails
                                                            .value
                                                            .data
                                                            ?.invoiceFiles
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index1) {
                                                          var singleAttach = ctr
                                                                  .inVoiceDetails
                                                                  .value
                                                                  .data
                                                                  ?.invoiceFiles?[
                                                              index1];
                                                          return singleAttach
                                                                      ?.files !=
                                                                  null
                                                              ? ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      primary:
                                                                          false,
                                                                      itemCount: singleAttach
                                                                          ?.files
                                                                          ?.length,
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        var singleFile = ctr
                                                                            .inVoiceDetails
                                                                            .value
                                                                            .data
                                                                            ?.invoiceFiles?[index1]
                                                                            .files?[index];
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Get.to(() => FullScreenView(
                                                                                url: "${ApiLinks.assetBasePath}$singleFile",
                                                                                tag: "${ApiLinks.assetBasePath}$singleFile",
                                                                                singleAttach: singleFile!));
                                                                          },
                                                                          child:
                                                                              Hero(
                                                                            tag:
                                                                                "${ApiLinks.assetBasePath}$singleFile",
                                                                            child:
                                                                                Container(
                                                                              width: 60,
                                                                              height: 60,
                                                                              margin: const EdgeInsets.only(right: 10, top: 5),
                                                                              //padding: const EdgeInsets.all(8),
                                                                              decoration: BoxDecoration(
                                                                                color: R.colors.grey,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  child: Image.network(
                                                                                    "${ApiLinks.assetBasePath}/$singleFile",
                                                                                    fit: BoxFit.cover,
                                                                                    errorBuilder: (context, error, stackTrace) {
                                                                                      return Center(child: Text('No Data'.tr));
                                                                                    },
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      })
                                                              : Container();
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //  Container(
                                            //   width: 60,
                                            //   height: 60,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(8),
                                            //     color: R.colors.grey
                                            //      ),
                                            //  ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Text(
                                              'Attach'.tr,
                                              style: TextStyle(
                                                  color: R.colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Container(
                                                  width: Get.width,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 0),
                                                  height: 70,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            pickImage(
                                                                ImageSource
                                                                    .gallery);
                                                          },
                                                          child: Container(
                                                            height: 60,
                                                            width: 60,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10,
                                                                    top: 1),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(18),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  R.colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Image.asset(
                                                              'assets/images/attach.png',
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        if (kIsWeb == false)
                                                          GestureDetector(
                                                            onTap: () async {
                                                              DeviceInfoPlugin
                                                                  deviceInfo =
                                                                  DeviceInfoPlugin();
                                                              if (Platform
                                                                  .isAndroid) {
                                                                AndroidDeviceInfo
                                                                    androidInfo =
                                                                    await deviceInfo
                                                                        .androidInfo;
                                                                final status =
                                                                    await Permission
                                                                        .camera
                                                                        .request();
                                                                final status2 = androidInfo
                                                                            .version.sdkInt <
                                                                        33
                                                                    ? await Permission
                                                                        .storage
                                                                        .request()
                                                                    : await Permission
                                                                        .photos
                                                                        .request();

                                                                if (status ==
                                                                        PermissionStatus
                                                                            .granted &&
                                                                    status2 ==
                                                                        PermissionStatus
                                                                            .granted) {
                                                                  _startScan(
                                                                      context);
                                                                } else {
                                                                  openAppSettings();
                                                                  // Get.snackbar("Error".tr, "Permission not granted");
                                                                }
                                                              }

                                                              //  pickImage(ImageSource.gallery);
                                                            },
                                                            child: Container(
                                                                height: 60,
                                                                width: 60,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        top: 1),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        18),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: R
                                                                      .colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .qr_code_scanner_rounded,
                                                                  //size: 28.sp,
                                                                  color: R
                                                                      .colors
                                                                      .white,
                                                                )),
                                                          ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),

                                                        Expanded(
                                                            child: ListView
                                                                .builder(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: ctr
                                                                        .uploadImages
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      var singleFile =
                                                                          ctr.uploadImages[
                                                                              index];
                                                                      return Stack(
                                                                          //alignment: Alignment.topRight,
                                                                          children: [
                                                                            Container(
                                                                              width: 60,
                                                                              height: 60,
                                                                              margin: const EdgeInsets.only(right: 10, top: 5),
                                                                              padding: const EdgeInsets.all(8),
                                                                              decoration: BoxDecoration(
                                                                                // color: R.colors.grey,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: kIsWeb == true
                                                                                  ? Image.network(
                                                                                      singleFile.path,
                                                                                      height: 25.h,
                                                                                      width: 25.w,
                                                                                    )
                                                                                  : Image.file(
                                                                                      singleFile,
                                                                                      height: 25.h,
                                                                                      width: 25.w,
                                                                                    ),
                                                                            ),
                                                                            Positioned(
                                                                                top: 0,
                                                                                right: 5,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    ctr.uploadImages.removeAt(index);
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    //padding: const EdgeInsets.all(5),
                                                                                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                                                    child: Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Icon(
                                                                                        Icons.close,
                                                                                        size: 12,
                                                                                        color: R.colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ))
                                                                          ]);
                                                                    })),
                                                        //  Container(
                                                        //   width: 60,
                                                        //   height: 60,
                                                        //   decoration: BoxDecoration(
                                                        //     borderRadius: BorderRadius.circular(8),
                                                        //     color: R.colors.grey
                                                        //      ),
                                                        //  ),

                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        //   Padding(
                                                        //     padding: const EdgeInsets
                                                        //             .symmetric(
                                                        //         horizontal:
                                                        //             12),
                                                        //     child: Text(
                                                        //       'Attach'.tr,
                                                        //       style: TextStyle(
                                                        //           color: R
                                                        //               .colors
                                                        //               .grey,
                                                        //           fontSize:
                                                        //               14,
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .w500),
                                                        //     ),
                                                        //   ),
                                                        //   const SizedBox(
                                                        //     height: 5,
                                                        //   ),
                                                        //   Padding(
                                                        //     padding: const EdgeInsets
                                                        //             .symmetric(
                                                        //         horizontal:
                                                        //             12),
                                                        //     child: Container(
                                                        //       width:
                                                        //           Get.width,
                                                        //       padding: const EdgeInsets
                                                        //               .symmetric(
                                                        //           vertical:
                                                        //               0),
                                                        //       height: 70,
                                                        //       child: Row(
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .start,
                                                        //         children: [
                                                        //           GestureDetector(
                                                        //             onTap:
                                                        //                 () {
                                                        //               pickImage(
                                                        //                   ImageSource.gallery);
                                                        //             },
                                                        //             child:
                                                        //                 Container(
                                                        //               height:
                                                        //                   60,
                                                        //               width:
                                                        //                   60,
                                                        //               margin: const EdgeInsets.only(
                                                        //                   right:
                                                        //                       10,
                                                        //                   top:
                                                        //                       1),
                                                        //               padding:
                                                        //                   const EdgeInsets.all(18),
                                                        //               decoration:
                                                        //                   BoxDecoration(
                                                        //                 color: R
                                                        //                     .colors
                                                        //                     .grey,
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(8),
                                                        //               ),
                                                        //               child: Image
                                                        //                   .asset(
                                                        //                 'assets/images/attach.png',
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //           const SizedBox(
                                                        //             width: 5,
                                                        //           ),
                                                        //           if (kIsWeb ==
                                                        //               false)
                                                        //             GestureDetector(
                                                        //               onTap:
                                                        //                   () async {
                                                        //                 DeviceInfoPlugin
                                                        //                     deviceInfo =
                                                        //                     DeviceInfoPlugin();
                                                        //                 if (Platform
                                                        //                     .isAndroid) {
                                                        //                   AndroidDeviceInfo
                                                        //                       androidInfo =
                                                        //                       await deviceInfo.androidInfo;
                                                        //                   final status =
                                                        //                       await Permission.camera.request();
                                                        //                   final status2 = androidInfo.version.sdkInt < 33
                                                        //                       ? await Permission.storage.request()
                                                        //                       : await Permission.photos.request();

                                                        //                   if (status == PermissionStatus.granted &&
                                                        //                       status2 == PermissionStatus.granted) {
                                                        //                     _startScan(context);
                                                        //                   } else {
                                                        //                     openAppSettings();
                                                        //                     // Get.snackbar("Error".tr, "Permission not granted");
                                                        //                   }
                                                        //                 }

                                                        //                 //  pickImage(ImageSource.gallery);
                                                        //               },
                                                        //               child: Container(
                                                        //                   height: 60,
                                                        //                   width: 60,
                                                        //                   margin: const EdgeInsets.only(right: 10, top: 1),
                                                        //                   padding: const EdgeInsets.all(18),
                                                        //                   decoration: BoxDecoration(
                                                        //                     color: R.colors.grey,
                                                        //                     borderRadius: BorderRadius.circular(8),
                                                        //                   ),
                                                        //                   child: Icon(
                                                        //                     Icons.qr_code_scanner_rounded,
                                                        //                     //size: 28.sp,
                                                        //                     color: R.colors.white,
                                                        //                   )),
                                                        //             ),
                                                        //           const SizedBox(
                                                        //             width: 5,
                                                        //           ),
                                                        //           Expanded(
                                                        //             child: ListView.builder(
                                                        //                 scrollDirection: Axis.horizontal,
                                                        //                 shrinkWrap: true,
                                                        //                 itemCount: ctr.uploadImages.length,
                                                        //                 itemBuilder: (context, index) {
                                                        //                   var singleFile =
                                                        //                       ctr.uploadImages[index];
                                                        //                   return Stack(
                                                        //                     //alignment: Alignment.topRight,
                                                        //                     children: [
                                                        //                       Container(
                                                        //                         width: 60,
                                                        //                         height: 60,
                                                        //                         margin: const EdgeInsets.only(right: 10, top: 5),
                                                        //                         padding: const EdgeInsets.all(8),
                                                        //                         decoration: BoxDecoration(
                                                        //                           // color: R.colors.grey,
                                                        //                           borderRadius: BorderRadius.circular(10),
                                                        //                         ),
                                                        //                         child: kIsWeb == true
                                                        //                             ? Image.network(
                                                        //                                 singleFile.path,
                                                        //                                 height: 25.h,
                                                        //                                 width: 25.w,
                                                        //                               )
                                                        //                             : Image.file(
                                                        //                                 singleFile,
                                                        //                                 height: 25.h,
                                                        //                                 width: 25.w,
                                                        //                               ),
                                                        //                       ),
                                                        //                       Positioned(
                                                        //                           top: 0,
                                                        //                           right: 5,
                                                        //                           child: GestureDetector(
                                                        //                               onTap: () {
                                                        //                                 ctr.uploadImages.removeAt(index);
                                                        //                               },
                                                        //                               child: Container(
                                                        //                                 height: 20,
                                                        //                                 width: 20,
                                                        //                                 //padding: const EdgeInsets.all(5),
                                                        //                                 decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                        //                                 child: Align(
                                                        //                                   alignment: Alignment.center,
                                                        //                                   child: Icon(
                                                        //                                     Icons.close,
                                                        //                                     size: 12,
                                                        //                                     color: R.colors.white,
                                                        //                                   ),
                                                        //                                 ),
                                                        //                               )))
                                                        //                     ],
                                                        //                   );
                                                        //                 }),
                                                        //           ),
                                                        //         ],
                                                        //       ),
                                                        //   ),
                                                        // ),
                                                      ]))),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 12),
                                            child: InkWell(
                                              onTap: () {
                                                if (GetStorage()
                                                        .read("user_type") ==
                                                    3) {
                                                  Get.snackbar(
                                                      "Error".tr,
                                                      "You do not have access"
                                                          .tr);
                                                  return;
                                                }
                                                if (ctr.uploadImages.isEmpty) {
                                                  Get.snackbar('Error'.tr,
                                                      "Attach image".tr);
                                                  return;
                                                }
                                                ctr.postInvoiceAttach(
                                                    widget.id);
                                              },
                                              child: Container(
                                                width: Get.width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: R.colors.themeColor),
                                                child: Center(
                                                    child: Text(
                                                  'Send'.tr,
                                                  style: TextStyle(
                                                      color: R.colors.white),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ])))))
                      ]
                    ])));
  }
}
