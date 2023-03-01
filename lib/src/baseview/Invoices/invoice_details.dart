import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sarf/controllers/members/members_controller.dart';

import '../../../constant/api_links.dart';
import '../../../resources/resources.dart';
import '../../utils/routes_name.dart';
import '../../widgets/custom_appbar.dart';

class InvoiceDetails extends StatefulWidget {
  final String id;
  const InvoiceDetails({super.key, required this.id});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  MembersController ctr = Get.put<MembersController>(MembersController());
  Future pickImage(ImageSource source) async {
    
    try {
      var pickedFile = await ImagePicker().pickMultiImage(imageQuality: 35);
      // var pickedFile = await picker.pickImage(source: source, imageQuality: 35);
      // ignore: unnecessary_null_comparison
      if (pickedFile == null) return;
      for (var item in pickedFile) {
        ctr.uploadImages.add(File(item.path))  ;
        
        
      }

    } on PlatformException catch(e) {
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
    
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            customAppBar('Invoice'.tr,true,false,'',true),
            //appbarSearch(),
            //const SizedBox(height: 10,),
            if(ctr.loadingInvoiceDetails.value == true)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),),
            ),
            if(ctr.loadingInvoiceDetails.value == false && ctr.inVoiceDetails.value.data == null)
            Center(child: Text('No Data'.tr,style: TextStyle(fontSize: 16),),),
            if(ctr.inVoiceDetails.value.data  != null)...[
              Transform(
            transform: Matrix4.translationValues(0, -10, 0),
             child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: R.colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Invoice No'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(ctr.inVoiceDetails.value.data!.createdDate!,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Text(ctr.inVoiceDetails.value.data!.id.toString(),style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 10,),
                        Text('Customer Name'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                         const SizedBox(height: 5,),
                        Text(ctr.inVoiceDetails.value.data!.customer!.name!,style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 10,),
                        Text('Description'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                         const SizedBox(height: 5,),
                        Text(ctr.inVoiceDetails.value.data!.note ?? '',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: R.colors.lightGrey,
                             ),
                             child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Net Total'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.w500),),
                                Text(ctr.inVoiceDetails.value.data!.amount.toString(),style: TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                             ),
                        ),
                      ],
                    ),
                  ),
                  
           ),
           const SizedBox(height: 10,),
           Expanded(child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Text('Received Attachments'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
           ),
           const SizedBox(height: 8,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Container(
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
                                                              itemCount: ctr.inVoiceDetails.value.data?.attachments?.length,
                                                              itemBuilder: (context,index){
                                                                var singleAttach = ctr.inVoiceDetails.value.data?.attachments?[index];
                                                              return GestureDetector(
                                                                onTap: ()async{
                                                                  try {
  // Saved with this method.
                                                                      var imageId = await ImageDownloader.downloadImage("${ApiLinks.assetBasePath}$singleAttach",destination: AndroidDestinationType.directoryDownloads..subDirectory("Sarf/$singleAttach") );
                                                                      if (imageId == null) {
                                                                        return;
                                                                      }

                                                                      // Below is a method of obtaining saved image information.
                                                                      var fileName = await ImageDownloader.findName(imageId);
                                                                      var path = await ImageDownloader.findPath(imageId);
                                                                      var size = await ImageDownloader.findByteSize(imageId);
                                                                      var mimeType = await ImageDownloader.findMimeType(imageId);
                                                                      
                                                                    } on PlatformException catch (error) {
                                                                      
                                                                      debugPrint(error.toString());
                                                                    }
                                                                },
                                                                child: Container(
                                                                  
                                                                  width: 60,
                                                                  height: 60,
                                                                  margin: const EdgeInsets.only(right: 10,top: 5),
                                                                  //padding: const EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(
                                                                    color: R.colors.grey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    child: Image.network("${ApiLinks.assetBasePath}$singleAttach",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace){
                                                                      return  Center(child: Text('No Data'.tr));
                                                                    } ,)),
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
           const SizedBox(height: 10,), 
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Divider(
              color: R.colors.lightBlue4,
              thickness: 0.1,
             ),
           ),
           const SizedBox(height: 10,), 
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Text('Sent Attachments'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
           ),
           const SizedBox(height: 8,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Container(
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
                                                              itemCount: ctr.inVoiceDetails.value.data?.attachments?.length,
                                                              itemBuilder: (context,index){
                                                                var singleAttach = ctr.inVoiceDetails.value.data?.attachments?[index];
                                                              return GestureDetector(
                                                                onTap: ()async{
                                                                  try {
  // Saved with this method.
                                                                      var imageId = await ImageDownloader.downloadImage("${ApiLinks.assetBasePath}$singleAttach",destination: AndroidDestinationType.directoryDownloads..subDirectory("Sarf/$singleAttach") );
                                                                      if (imageId == null) {
                                                                        return;
                                                                      }

                                                                      // Below is a method of obtaining saved image information.
                                                                      var fileName = await ImageDownloader.findName(imageId);
                                                                      var path = await ImageDownloader.findPath(imageId);
                                                                      var size = await ImageDownloader.findByteSize(imageId);
                                                                      var mimeType = await ImageDownloader.findMimeType(imageId);
                                                                    } on PlatformException catch (error) {
                                                                      debugPrint(error.toString());
                                                                    }
                                                                },
                                                                child: Container(
                                                                  
                                                                  width: 60,
                                                                  height: 60,
                                                                  margin: const EdgeInsets.only(right: 10,top: 5),
                                                                  //padding: const EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(
                                                                    color: R.colors.grey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                  ),
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10),
                                                                    child: Image.network("${ApiLinks.assetBasePath}/$singleAttach",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace){
                                                                      return  Center(child: Text('No Data'.tr));
                                                                    },)),
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
           const SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12),
             child: Text('Attach'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
           ),
           const SizedBox(height: 5,),
      
           Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 0),
            height: 70,
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                                GestureDetector(
                                  onTap: (){
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    
                                          height: 60,
                                          width: 60,
                                          margin: const EdgeInsets.only(right: 10,top: 1),
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
                                    const SizedBox(width: 5,),
             
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: ctr.uploadImages.length,
                                        itemBuilder: (context,index){
                                          var singleFile = ctr.uploadImages[index];
                                         return Stack(
                                        //alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            
                                            width: 60,
                                            height: 60,
                                            margin: const EdgeInsets.only(right: 10,top: 5),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                             // color: R.colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Image.file(
                                            singleFile,
                                            height: 25.h,
                                            width: 25.w,
                                          ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: (){
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
            height: 20,
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
          child: InkWell(
                  onTap: (){
                    if(ctr.uploadImages.isEmpty){
                      
                      Get.snackbar('Error'.tr, "Attach image".tr);
                      return;
                    }
                    ctr.postInvoiceAttach(widget.id);
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: R.colors.themeColor),
                    child: Center(
                        child: Text(
                      'Send'.tr,
                      style: TextStyle(color: R.colors.white),
                    )),
                  ),
                ),
          ),
              ],
            ),
           )
           ),
            ],
           
           
           
      
          ],
        ),
      ),
    );
  }
}