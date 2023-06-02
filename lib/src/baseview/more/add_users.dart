import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sarf/controllers/viewers/viewers_controller.dart';
import 'package:sarf/src/baseview/more/add_new_user.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddUsersScreen extends StatefulWidget {
  const AddUsersScreen({super.key});

  @override
  State<AddUsersScreen> createState() => _AddUsersScreenState();
}

class _AddUsersScreenState extends State<AddUsersScreen> {
  ViewersController ctr = Get.put<ViewersController>(ViewersController());
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey ,
      body: SafeArea(child: Obx(
        () => Column(children: [
          Container(
              padding: EdgeInsets.only(left: GetStorage().read("lang") == 'en'?  16.w : 0, top: 5.h,right: GetStorage().read("lang") == 'en'? 0:16.w ),
              height: 80.h,
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
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: GetStorage().read('lang') == 'en' ? Alignment.centerLeft : Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                      'Add User'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      ],
                    ),
      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
          child: customButton(
            optionalNavigateIcon: false,
            margin: 0,
            width: MediaQuery.of(context).size.width / 3.5,
            titleTextAlign: TextAlign.center,
            title: 'Add User'.tr,
            color: R.colors.black,
            textColor: R.colors.white,
            height: 35,
            borderColour: R.colors.transparent,
            onPress: (() {
               Get.to(() => const AddNewUserScreen() );
            }),
          ),
        ),
                    ),
                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            if(ctr.userData.value.data == null)
            Center(child: Text("No Data".tr),),
            if(ctr.userData.value.data != null)
            Expanded(child: Column(
              children: [
                Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: budgetName(),
          ),
          const SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: ctr.userData.value.data?.length,
                    itemBuilder: (context,index){
                      var singleData = ctr.userData.value.data?[index];
                      // ScreenshotController screenshotController = ScreenshotController();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        width: Get.width,
                        height: 120,
                        decoration: BoxDecoration(
                          color: R.colors.white,
                          borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Text('Name'.tr,style: TextStyle(fontSize: 12,color: R.colors.grey),),
                                // const SizedBox(height: 5,),
                                // Text(singleData?.username ?? "",style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.bold),),
                                // const SizedBox(height: 10,),
                                Screenshot(
                                  controller: ctr.screenCtr[index],
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    color: R.colors.white,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Mobile Number'.tr,
                                        
                                        // contextMenuBuilder: () ,
                                        style: TextStyle(fontSize: 12,color: R.colors.grey),),
                                                                  const SizedBox(height: 10,),
                                                                  Text(singleData?.mobile ?? '',
                                                                  
                                                                  style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.bold),),
                                                                  const SizedBox(height: 10,),
                                                                  Text('Password'.tr,
                                                                                                                   style: TextStyle(fontSize: 12,color: R.colors.grey),),
                                                                  const SizedBox(height: 10,),
                                                                  Text(singleData?.passwordValue ?? '',
                                                                                                                   style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.bold),),
                                                                  // SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                                // Text('Mobile Number'.tr,style: TextStyle(fontSize: 12,color: R.colors.grey),),
                                // const SizedBox(height: 5,),
                                // Text(singleData?.mobile ?? '',style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.bold),),
                                // const SizedBox(height: 10,),
                                // Text('Password'.tr,style: TextStyle(fontSize: 12,color: R.colors.grey),),
                                // const SizedBox(height: 5,),
                                // Text(singleData?.passwordValue ?? '',style: TextStyle(fontSize: 14,color: R.colors.black,fontWeight: FontWeight.bold),),
                                // // SizedBox(height: 10,),
                              
                              ],),
                            Expanded(
                              child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 mainAxisSize: MainAxisSize.max,
                                children: [
                                  GestureDetector (
                                        onTap: () async{
                                          print("here");
                                          final directory = (await getApplicationDocumentsDirectory()).path;
                                ctr.screenCtr[index].capture().then((Uint8List? image) async {
                                  if (image != null) {
                                    try {
                                      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                                      final imagePath = await File('$directory/$fileName.png').create();
                                      await imagePath.writeAsBytes(image);
                                      
                                      // ignore: deprecated_member_use
                                      Share.shareXFiles([XFile(imagePath.path)]);
                                    } catch (error) {
                                      debugPrint(error.toString());
                                    }
                                  }
                                }).catchError((onError) {
                                  debugPrint('Error --->> $onError');
                                });
                                        },
                                        child: Text('Share'.tr,style: TextStyle(fontSize: 12,color: R.colors.blue,decoration: TextDecoration.underline),)),
                                  //  Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                       Clipboard.setData(ClipboardData(text: "${'Mobile Number'.tr} : ${singleData?.mobile}\n${'Password'.tr} : ${singleData?.passwordValue}"));
                                       Get.snackbar("Copied to Clipboard".tr, "" );
                                    },
                                    child: Text("Copy".tr,style: TextStyle(color: R.colors.blue,decoration: TextDecoration.underline),),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      ctr.removeViewer(singleData!.id.toString());
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.delete,color: R.colors.themeColor,),
                                        const SizedBox(width: 5,),
                                        Text("Delete".tr,style: TextStyle(color: R.colors.themeColor),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],),
                      );
                    }),
                ),
              ],
            )),
        ],),
      )),
    );
  }
}