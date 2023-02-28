import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/alerts/alert_controller.dart';

import '../../../resources/resources.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  AlertsController ctr = Get.put<AlertsController>(AlertsController());
  @override
  void initState() {
    ctr.getAlerts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Obx(
        () => ctr.isLoadingAlert.value == true? Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),)  : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
            padding: EdgeInsets.only(left: 16.w, top: 20.h,right: 16.w),
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
                    'Alerts'.tr ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  const SizedBox(width: 8,),
      
                  Text(
                    '(${ctr.alerts.value.data?.alertCount ?? 0})' ,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  ],),
                  
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: (){
                        ctr.clearAlerts();
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: R.colors.white
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Icon(Icons.close,color: R.colors.lightBlue3,size: 12,),
                          ),
                          const SizedBox(width: 8,),
                          Text('Clear All'.tr,style: TextStyle(color: R.colors.white,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  ),
      
                ],
              ),
            ),
          ),
           Expanded(
             child: ctr.alerts.value.data == null ?  Center(child: Text('No Data'.tr,style: TextStyle(fontSize: 16),),)  : ListView.builder(
                itemCount: ctr.alerts.value.data?.alerts?.length,
                itemBuilder: (context,index){
                  var singleData = ctr.alerts.value.data?.alerts?[index];
                return GestureDetector(
                  onTap: (){
                    ctr.readAlert(singleData!.id.toString());
                  },
                  child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          color: R.colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(GetStorage().read('lang') == "en" ? singleData?.title?.en ?? '' : singleData?.title?.ar ?? '' ,style: TextStyle(color: R.colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                                Text('${singleData?.createdDate} - ${singleData?.createdTime}',style: TextStyle(color: Color(0xFF28527A),fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Text(GetStorage().read('lang') == "en" ? singleData?.description?.en ?? '' : singleData?.description?.ar ?? '',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),),
                          ],
                        ),
                      ),
                );
               }),
             
           ),
           
          ],
        ),
      ),
    );
  }
}