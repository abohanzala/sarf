import 'dart:async';
import 'dart:io';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/home/home_controller.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/resources/resources.dart';
import 'package:sarf/src/baseview/members/qr_code_scanner.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:scan/scan.dart';

import '../../utils/navigation_observer.dart';
import '../../widgets/custom_appbar.dart';

class CustomInvoice extends StatefulWidget {
  const CustomInvoice({super.key});

  @override
  State<CustomInvoice> createState() => _CustomInvoiceState();
}

class _CustomInvoiceState extends State<CustomInvoice> with RouteAware  {
  File? _scannedImage;
  InvoiceController ctr = Get.find<InvoiceController>();
  HomeController homeController = Get.find<HomeController>();
 

  void _startScan(BuildContext context) async {
    try{
      var image = await DocumentScannerFlutter.launch(context,source: ScannerFileSource.CAMERA)?.catchError((error){
        Get.snackbar("Error".tr, error.toString(),backgroundColor: R.colors.blue);
      });

    if (image != null) {
      _scannedImage = image;
      ctr.uploadImages.add(_scannedImage!);
      setState(() {});
    }
    } on PlatformException catch (e) {
      Get.snackbar("Error".tr,e.toString());
      debugPrint('Failed to pick image: $e');
    }
    
  }

 

  Future pickImage(ImageSource source) async {
    try {
      var pickedFile = await ImagePicker().pickMultiImage();
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
  initState(){
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Helper.routeObserver.subscribe(this, ModalRoute.of(context)!);
  });

    Future.delayed(Duration.zero,(){
      ctr.uploadImages.clear();
      ctr.amount22.clear();
      ctr.note33.clear();
    });
    
    super.initState();

    

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Stack(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: GetStorage().read("lang") == 'en'?  16.w : 0, top: 20.h,right: GetStorage().read("lang") == 'en'? 0:16.w ),
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
              alignment: GetStorage().read('lang') == 'en' ? Alignment.centerLeft : Alignment.centerRight,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back() ,
                    child: Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: R.colors.white,
                      ),
                      child: Icon(Icons.arrow_back_ios,color: R.colors.black,size: 20,),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    'Generate Custom Invoice'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                    padding:  EdgeInsets.only(left: 12.w,right: 12.w,top: 15.h,bottom: 20),
                    child: Form(
                      child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                              // Text('Mobile Number'.tr,style: TextStyle(
                              //       color: R.colors.grey,
                              //       fontSize: 14.sp,
                              //     ),),
                              //     const SizedBox(height: 5,),
                                  GestureDetector(
                                    onTap: (){
                                      Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: R.colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                padding: const EdgeInsets.all(10),
                                child: Obx(
                                  () => ListView.separated(
                                      itemBuilder: (context, index) {
                                        var singleData =
                                            homeController.budgets[index];
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
                                                ctr.selectedBudgetId.value = singleData.id.toString();
                                                ctr.selectedBudgetName.value = singleData.name == 'Expenses' ? GetStorage().read('name') : singleData.name ?? '';
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
                                                          color: ctr.selectedBudgetId
                                                                          .value 
                                                                       ==
                                                                  singleData.id.toString()
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
                                                     singleData.name == 'Expenses' ? GetStorage().read('name') : singleData.name ?? '',
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
                                      itemCount: homeController.budgets.length),
                                ),
                              ),
                            );
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                      decoration: BoxDecoration(
                                        color: R.colors.lightGrey,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Obx( () => Text(ctr.selectedBudgetName.value.tr,style: TextStyle(color: ctr.selectedBudgetName.value != "Select Category" ? R.colors.black : R.colors.grey ),)),
                                          Icon(Icons.arrow_drop_down,color: R.colors.black,)
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                             
                               SizedBox(
                                  height: 10.h,
                                ),
                                GestureDetector(
                                    onTap: (){
                                      Get.bottomSheet(
                              Container(
                                decoration: BoxDecoration(
                                    color: R.colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                padding: const EdgeInsets.all(10),
                                child: Obx(
                                  () => ListView.separated(
                                      itemBuilder: (context, index) {
                                        var singleData =
                                            homeController.expenseTypes[index];
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
                                                ctr.selectedExptId.value = singleData.id.toString();
                                                ctr.selectedExpName.value =  GetStorage().read('lang') == 'en'? singleData.expenseName ?? '' : singleData.expenseNameAr ?? '' ;
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
                                                          color: ctr.selectedExptId
                                                                          .value 
                                                                       ==
                                                                  singleData.id.toString()
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
                                                     GetStorage().read('lang') == 'en'? singleData.expenseName ?? '' : singleData.expenseNameAr ?? '',
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
                                      itemCount: homeController.expenseTypes.length),
                                ),
                              ),
                            );
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                      decoration: BoxDecoration(
                                        color: R.colors.lightGrey,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                           Obx( () => Text(ctr.selectedExpName.value.tr,style: TextStyle(color: ctr.selectedExpName.value != "Select Expanse" ? R.colors.black : R.colors.grey ),)),
                                          Icon(Icons.arrow_drop_down,color: R.colors.black,)
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                               SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  controller: ctr.amount22,
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
                                  controller: ctr.note33,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    fillColor: R.colors.lightGrey,
                                    filled: true,
                                    labelText: 'Description(Optional)'.tr,
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
                                 Container(
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
                                          child: Obx(
                                            () => ListView.builder(
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
                                        ),
                                      ],
                                    ),
                                  ),
                                
                                                         
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (ctr.selectedBudgetId.value == '') {
                                            Get.snackbar('Error'.tr, "Category is required".tr);
                                            return;
                                          }

                                           if (ctr.selectedExptId.value == '') {
                                            Get.snackbar('Error'.tr, "Expanse is required".tr);
                                            return;
                                          }

                                          if (ctr.amount22.text.isEmpty) {
                                            Get.snackbar('Error'.tr, "amount is required".tr);
                                            return;
                                          }
                                          String b = replaceArabicNumber(ctr.amount22.text);
                                         ctr.postNewCustomInvoice(ctr.selectedBudgetId.value, ctr.selectedExptId.value,b, ctr.note33.text);
                                        },
                                        child: Container(
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            color: R.colors.themeColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Send'.tr,
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
                                ),
                                      ],
                                    ),
                                
                             
                    )
                            ,
                          ),
                      
                      
        ]),
                  ),
                  
                 
      )],
              ),
            );
            
  }
}
