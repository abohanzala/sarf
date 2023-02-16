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
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/invoice/invoice_controller.dart';
import 'package:sarf/resources/resources.dart';
import 'package:sarf/src/baseview/members/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../../utils/navigation_observer.dart';

class SimpleInvoice extends StatefulWidget {
  const SimpleInvoice({super.key});

  @override
  State<SimpleInvoice> createState() => _SimpleInvoiceState();
}

class _SimpleInvoiceState extends State<SimpleInvoice> with RouteAware {
  File? _scannedImage;
  Timer? searchOnStoppedTyping;
  String name = "";
  bool searching = false;

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

  InvoiceController ctr = Get.find<InvoiceController>();

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


   Future pickImageQr() async {
    try {
      var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      // var pickedFile = await picker.pickImage(source: source, imageQuality: 35);
      // ignore: unnecessary_null_comparison
      if (pickedFile == null) return;
      ctr.mobile1.text = (await Scan.parse(pickedFile.path))!;
      ctr.checkMobile = true;
      Get.back();
      // for (var item in pickedFile) {
      //   ctr.uploadImages.add(File(item.path));
      // }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Helper.routeObserver.subscribe(this, ModalRoute.of(context)!);
  });

    ctr.mobile1.clear();
    ctr.amount2.clear();
    ctr.note3.clear();
    ctr.uploadImages.clear();
    super.initState();

  }

  @override
  void didPopNext() {
    if(ctr.checkMobile){
      // _onChangeHandler(ctr.mobile1.text);
      ctr.mobileCheck(ctr.mobile1.text).then((value){
          if(value['message'] == 'User record available'){
            setState(() {
              name = value['user']['name'];
            });
          }
          if(value['message'] == 'User not found!'){
            setState(() {
              name = "User not found".tr;
            });
          }
        });
    } 
    
    super.didPopNext();
  }
  
   

    _onChangeHandler(value) {
        const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
        if (searchOnStoppedTyping != null) {
            setState(() => searchOnStoppedTyping?.cancel()); // clear timer
        }
        setState(() => searchOnStoppedTyping =  Timer(duration, () => search(value)));
    }

    search(value) {
        //print('hello world from search . the value is $value');
        if(value.isEmpty){
          // qrCode = false;
          setState(() {
            searching = false;
          });
          return;
        }
        
        ctr.getMobileUsers(ctr.mobile1.text).then((value)async{
          if(ctr.searchedUsers.value.data != null){
            setState(() {
              searching = true;
            });
          }
         await ctr.mobileCheck(ctr.mobile1.text).then((value){
          if(value['message'] == 'User record available'){
            setState(() {
              name = value['user']['name'];
            });
          }
          if(value['message'] == 'User not found!'){
            setState(() {
              name = "User not found".tr;
            });
          }
        });
        });

        //print(ctr.mobile1.text);
        
    }

    @override
    void dispose() {
    searchOnStoppedTyping?.cancel();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
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
          Expanded(
            child: Transform(
              transform: Matrix4.translationValues(0, -40.h, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                padding:  EdgeInsets.only(left: 12.w,right: 12.w,top: 15.h,bottom: 10),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mobile Number'.tr,style: TextStyle(
                                  color: R.colors.grey,
                                  fontSize: 14.sp,
                                ),),
                                const SizedBox(height: 5,),
                            TextFormField(
                              //initialValue: ctr.mobile1.text,
                              controller: ctr.mobile1,
                              onChanged: _onChangeHandler,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    Get.bottomSheet(Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        color: R.colors.white,
                                        
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                              // qrCode = true;
                                              Get.to(() => const QRScannerScreen(invoice: true,) );
                                            },
                                            child: Text("Camera".tr,style: TextStyle(fontSize: 14,color: R.colors.black),)),
                                            const SizedBox(height: 10,),
                                            Divider(color: R.colors.grey,thickness: 0.5,),
                                            const SizedBox(height: 10,),
                                            GestureDetector(
                                            onTap: (){
                                              pickImageQr();
                                              
                                            },
                                            child: Text("Gallery".tr,style: TextStyle(fontSize: 14,color: R.colors.black),)),
                                        ],
                                      ),
                            
                                    ),
                                    );
                                    
                                  },
                                  child: Icon(
                                    Icons.qr_code,
                                    color: R.colors.blue,
                                    size: 25.sp,
                                  ),
                                ),
                                //'Mobile Number'.tr
                                fillColor: R.colors.lightGrey,
                                filled: true,
                                hintText: "9665----",
                               
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
                            Stack(
                              children: [
                               
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                              height: 10.h,
                            ),
                            if(name != '')
                            Text(
                              name,
                              style: TextStyle(
                                color: name == 'User not found'.tr? Colors.red : R.colors.black,
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
                           
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                      if (name == 'User not found') {
                                        Get.snackbar('Error'.tr, "Enter a valid number".tr);
                                        return;
                                      }
                                      if (ctr.mobile1.text.isEmpty) {
                                        Get.snackbar('Error'.tr, "mobile is required".tr);
                                        return;
                                      }
                                      if (ctr.amount2.text.isEmpty) {
                                        Get.snackbar('Error'.tr, "amount is required".tr);
                                        return;
                                      }
                                      if (ctr.note3.text.isEmpty) {
                                        Get.snackbar('Error'.tr, "note is required".tr);
                                        return;
                                      }
                                      FocusScope.of(context).unfocus();
                                      
                                      ctr
                                          .postNewInvoice(ctr.mobile1.text,
                                              ctr.amount2.text, ctr.note3.text)
                                          .then((value) {
                                            setState(() {
                                              name = '';
                                            });
                                          });
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
                            ),
                                  ],
                                ),
                                 if(searching) ...[
                              Obx( () => Container(
                                decoration: BoxDecoration(
                                  color: R.colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: R.colors.lightGrey,
                                      offset: Offset(0,2),
                                      spreadRadius: 2,
                                      blurRadius: 2
                                    ),
                                  ],
                                ),
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: ctr.searchedUsers.value.data?.length,
                                  itemBuilder: (context,index){
                                    var singleData = ctr.searchedUsers.value.data?[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: R.colors.lightGrey,
                                      radius: 25,
                                      backgroundImage: singleData?.photo == null ? null : NetworkImage("${ApiLinks.assetBasePath}${singleData?.photo}") ,
                                    ),
                                    title: Text(singleData?.name ?? ''),
                                    subtitle: Text(singleData?.mobile ?? ''),
                                    onTap: (){
                                      FocusScope.of(context).unfocus();
                                      ctr.mobile1.text = singleData?.mobile ?? '';
                                      setState(() {
                                        searching = false;
                                      });
                                      ctr.mobileCheck(ctr.mobile1.text).then((value){
                                          if(value['message'] == 'User record available'){
                                            setState(() {
                                              name = value['user']['name'];
                                            });
                                          }
                                          if(value['message'] == 'User not found!'){
                                            setState(() {
                                              name = "User not found".tr;
                                            });
                                          }
                                        });
                                    },
                                  );
                                }),
                              )),
                            ],
                            
                              ],
                            ),
                          ],
                        ),
                    
                    
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
