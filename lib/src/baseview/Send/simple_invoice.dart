import 'dart:io';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/resources/resources.dart';

class SimpleInvoice extends StatefulWidget {
  const SimpleInvoice({super.key});

  @override
  State<SimpleInvoice> createState() => _SimpleInvoiceState();
}

class _SimpleInvoiceState extends State<SimpleInvoice> {
  File? _scannedImage;

  void _startScan(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context);
    if (image != null) {
      _scannedImage = image;
      ctr.uploadImages.add(_scannedImage!);
      setState(() {});
    }
  }

  InvoiceController ctr = Get.find<InvoiceController>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h),
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  R.colors.blueGradient1,
                  R.colors.blueGradient2,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Simple Invoice'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(0, -40.h, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: ctr.mobile1,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.qr_code,
                          color: R.colors.blue,
                          size: 25.sp,
                        ),
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Mobile Number'.tr,
                        labelStyle: TextStyle(
                          color: R.colors.grey,
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: R.colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'NAME'.tr,
                      style: TextStyle(
                        color: R.colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: ctr.amount2,
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Amount'.tr,
                        labelStyle: TextStyle(
                          color: R.colors.grey,
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: R.colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: ctr.note3,
                      maxLines: 7,
                      decoration: InputDecoration(
                        fillColor: R.colors.lightGrey,
                        filled: true,
                        labelText: 'Description'.tr,
                        labelStyle: TextStyle(
                          color: R.colors.grey,
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: R.colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                margin:
                                    const EdgeInsets.only(right: 10, top: 1),
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: R.colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/attach.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                _startScan(context);

                                //  pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 1),
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: R.colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.qr_code_scanner_rounded,
                                    //size: 28.sp,
                                    color: R.colors.white,
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: ctr.uploadImages.length,
                                  itemBuilder: (context, index) {
                                    var singleFile = ctr.uploadImages[index];
                                    return Stack(
                                      //alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 5),
                                          decoration: BoxDecoration(
                                            //  color: R.colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.file(
                                              singleFile,
                                              height: 25.h,
                                              width: 25.w,
                                              fit: BoxFit.cover,
                                            ),
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
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Align(
                                                alignment: Alignment.center,
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
                    // Flexible(
                    //   fit: FlexFit.loose,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 8,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             GestureDetector(
                    //               onTap: (){
                    //                 pickImage(ImageSource.gallery);
                    //               },
                    //               child: Container(
                    //                 margin: EdgeInsets.only(top: 12.h),
                    //                 padding: const EdgeInsets.all(20),
                    //                 decoration: BoxDecoration(
                    //                   color: R.colors.grey,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Image.asset(
                    //                   'assets/images/attach.png',
                    //                   height: 25.h,
                    //                   width: 25.w,
                    //                 ),
                    //               ),
                    //             ),
                    //             GestureDetector(
                    //               onTap: (){
                    //                 pickImage(ImageSource.gallery);
                    //               },
                    //               child: Container(
                    //                   margin: EdgeInsets.only(top: 12.h),
                    //                   padding: const EdgeInsets.all(20),
                    //                   decoration: BoxDecoration(
                    //                     color: R.colors.grey,
                    //                     borderRadius: BorderRadius.circular(10),
                    //                   ),
                    //                   child: Icon(
                    //                     Icons.qr_code_scanner_rounded,
                    //                     size: 28.sp,
                    //                     color: R.colors.white,
                    //                   )),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5.w,
                    //       ),
                    //       Expanded(
                    //         flex: 9,
                    //         child: Obx(
                    //           () => SingleChildScrollView(
                    //             scrollDirection: Axis.horizontal,
                    //             child: Row(
                    //               children: List.generate(ctr.uploadImages.length, (index) {
                    //                 var singleFile = ctr.uploadImages[index];
                    //                 return Stack(
                    //                   alignment: Alignment.topRight,
                    //                   children: [
                    //                     Container(
                    //                       margin: EdgeInsets.only(
                    //                           left: 10.w, top: 12.h, right: 5.w),
                    //                       padding: const EdgeInsets.all(20),
                    //                       decoration: BoxDecoration(
                    //                         color: R.colors.grey,
                    //                         borderRadius:
                    //                             BorderRadius.circular(10),
                    //                       ),
                    //                       child: Image.file(
                    //                         singleFile,
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                     GestureDetector(
                    //                       onTap: (){
                    //                         ctr.uploadImages.removeAt(index);
                    //                       },
                    //                       child: Positioned(
                    //                         top: 3,
                    //                         right: 0,
                    //                         child: Container(
                    //                           height: 20.h,
                    //                           width: 20.w,
                    //                           padding: const EdgeInsets.all(5),
                    //                           decoration: const BoxDecoration(
                    //                               color: Colors.red,
                    //                               shape: BoxShape.circle),
                    //                           child: Align(
                    //                             alignment: Alignment.center,
                    //                             child: Icon(
                    //                               Icons.close,
                    //                               size: 13.sp,
                    //                               color: R.colors.white,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 );
                    //               }),
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (ctr.mobile1.text.isEmpty) {
                                Get.snackbar('Error'.tr, "mobile is required");
                                return;
                              }
                              if (ctr.amount2.text.isEmpty) {
                                Get.snackbar('Error'.tr, "amount is required");
                                return;
                              }
                              if (ctr.note3.text.isEmpty) {
                                Get.snackbar('Error'.tr, "note is required");
                                return;
                              }
                              FocusScope.of(context).unfocus();
                              ctr
                                  .postNewInvoice(ctr.mobile1.text,
                                      ctr.amount2.text, ctr.note3.text)
                                  .then((value) {});
                            },
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: R.colors.themeColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Send Invoice'.tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
