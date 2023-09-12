import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/home/home_controller.dart';
import '../../resources/resources.dart';


Container customAppBar(String title,bool back,bool braket,String? braketText,bool share,Function()? onTap) {

    return Container(
          padding: EdgeInsets.only(left: GetStorage().read('lang') == 'en' ? kIsWeb == true ? 0 : 16.w : 0, top: 20.h,right: GetStorage().read('lang') == 'en' ? 0 : kIsWeb == true ? 0 : 16.w),
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
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: kIsWeb == true ? Get.width * 0.11 : 0 ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Row(
                    children: [
                      if(back) ...[
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
                  ],
                  
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if(braket) ...[
                    const SizedBox(width: 5,),
                    Text(braketText!,style:TextStyle(
                      color: R.colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),)
                  ],
                    ],
                  ),
          
                  if(share)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Image.asset(R.images.icon3,width: 25,height: 25,color: R.colors.white,)),
                  ),
          
                ],
              ),
            ),
          ),
        );
  }

  Widget budgetName(){
    return const SizedBox();
    // HomeController ctr = Get.find<HomeController>();
    // return Row(children: [
      
    //   Obx(() => Text(ctr.selectedBudgetName.value == GetStorage().read("name") ? "Main Budget".tr :  ctr.selectedBudgetName.value ,style: const TextStyle(fontWeight: FontWeight.w500),)),
    // ],);
  }

  Transform appbarSearch() {
    return Transform(
          transform: Matrix4.translationValues(0, -20, 0),
          child: Container(
            //margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: R.colors.lightBlue2,
                                  border: Border.all(color: R.colors.lightBlue,width: 1) ),
                                  child:
                                  TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(bottom: 5),
                                      hintText: 'Search here'.tr,
                                      hintStyle: TextStyle(color: R.colors.grey),
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                  
                                    ),
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: R.colors.lightBlue2,border: Border.all(color: R.colors.lightBlue,width: 1)),
                                  child: Center(child: Row(
                                    children: [
                                          Icon(
                                            Icons.qr_code,
                                            color: R.colors.blue,
                                            //size: 25.sp,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text('SCAN'.tr,style: TextStyle(color: R.colors.blue,
                                          //fontSize: 25.sp
                                          ),)
                                    ],
                                  ),),
                                )
                ],
              ),
            ),
          ),
        );
  }