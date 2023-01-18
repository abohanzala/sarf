import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/support/support_controller.dart';

import '../../../resources/resources.dart';

class SingleSupport extends StatefulWidget {
  final String title;
  final String id;
  final String date;
  const SingleSupport({super.key, required this.title, required this.id, required this.date});

  @override
  State<SingleSupport> createState() => _SingleSupportState();
}

class _SingleSupportState extends State<SingleSupport> {
  TextEditingController txt = TextEditingController();
  SupportController ctr = Get.find<SupportController>();
  @override
  void initState() {
    if(widget.id.isEmpty) Get.back();
    ctr.getSupportDetails(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Obx(
        () => ctr.isLoadingSupportDetails.value == true ? Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),)  :  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h),
            height: 100,
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
              //borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
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
                    widget.title ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  ],),
                  
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(widget.date,style: TextStyle(color: R.colors.black,fontSize: 18.sp,fontWeight: FontWeight.w500),),
                  ),
      
                ],
              ),
            ),
          ),
           Expanded(
             child: Transform(
              transform: Matrix4.translationValues(0, -10, 0),
               child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                        color: R.colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('Invoice No',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          //     Text('12-04-2021',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          //   ],
                          // ),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              //height: 45,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              decoration: BoxDecoration(
                                color: R.colors.blue.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Type'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),
                                      Text('Status'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12,fontWeight: FontWeight.w500),),
                                  ],),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(ctr.supportDetails.value.data?.type == "0" ? "Business".tr : "Personal".tr,style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                      Text(ctr.supportDetails.value.data?.status == "0" ? "Pending".tr : "Success".tr,style:  TextStyle(color: ctr.supportDetails.value.data?.status == "0"? Color(0XFFF4BD05) : Color(0XFF2CC91F),fontSize: 14,fontWeight: FontWeight.w500),),
                                  ],),
      
                                  
           
                                ],
                              ),
                             
                            ),
                            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      
                                      Row(
                                        children: [
                                          Text('You'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.w700),),
                                          Text(' - ',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                                          Text(ctr.supportDetails.value.data?.createdDate ?? '',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 8,),
                                      Text(ctr.supportDetails.value.data?.message ?? '',
                                      style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),),
                                      const SizedBox(height: 10,),
                                     
                                      Container(
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
                                                              itemCount: ctr.supportDetails.value.data?.attachments?.length,
                                                              itemBuilder: (context,index){
                                                                var singleAttach = ctr.supportDetails.value.data?.attachments?[index];
                                                              return Container(
                                                                
                                                                width: 80,
                                                                height: 80,
                                                                margin: const EdgeInsets.only(right: 10,top: 5),
                                                                padding: const EdgeInsets.all(8),
                                                                decoration: BoxDecoration(
                                                                  //color: R.colors.grey,
                                                                  borderRadius:
                                                                      BorderRadius.circular(10),
                                                                ),
                                                                child: ClipRRect(
                                                                 borderRadius: BorderRadius.circular(10),
                                                                  child: Image.network("${ApiLinks.assetBasePath}/$singleAttach",fit: BoxFit.cover,)),
                                                              );
                                                            
                                                            }),
                                                          ),
                                    ],
                                  ),
                                ),
      
                                    ],
                                  ),
                            ),
                            Divider(
                                  color: R.colors.lightBlue4,
                                  thickness: 0.2,
                                ),
                            
                            Expanded(
                              child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                var singleDetail = ctr.supportDetails.value.data!.detail?[index];
                                return Container(
                                  margin: const EdgeInsets.only(top: 0,bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                       Row(
                                        children: [
                                          Text('Reply by '.tr,style: TextStyle(color: R.colors.blue,fontSize: 14,fontWeight: FontWeight.w700),),
                                          Text( singleDetail?.users?.name ?? '',style: TextStyle(color:  R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                                          Text(' - ',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                                          Text(singleDetail?.createdDate ?? '',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(singleDetail?.message ?? '',
                                      style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),),
                                      
      
                                    ],
                                  ),
                                );
                              }, 
                              separatorBuilder: (context,index){
                                return Divider(
                                  color: R.colors.lightBlue4,
                                  thickness: 0.2,
                                );
                              }, 
                              itemCount: ctr.supportDetails.value.data!.detail!.length)),
           
                        ],
                      ),
                    ),
             ),
           ),
           Transform(
            transform: Matrix4.translationValues(0, -5, 0),
             child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: R.colors.grey,
                    offset: const Offset(0,5),
                    spreadRadius: 5,
                    blurRadius: 20,
                  ),
                ],
                color: R.colors.white,
              ),
              width: Get.width,
              
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(color: R.colors.lightGrey,
                borderRadius: BorderRadius.circular(4),
                
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                child: Row(
                  children: [
                    Expanded(child: TextFormField(
                      controller: txt,
                      decoration:  InputDecoration(
                        hintText: 'Reply here'.tr,
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: (){
                        if(txt.text.isEmpty){
                          return;
                        }
                        ctr.supportReply(widget.id, txt.text).then((value){
                          txt.clear();
                        });
                      },
                      child: Icon(Icons.send,color: R.colors.themeColor,))
                  ],
                ),
              ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}