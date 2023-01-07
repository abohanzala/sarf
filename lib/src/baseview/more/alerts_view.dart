import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
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
                  'Alerts' ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8,),

                Text(
                  '(3)' ,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ],),
                
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      Text('Clear All',style: TextStyle(color: R.colors.white,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
         Expanded(
           child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context,index){
            return Container(
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
                          Text('Title',style: TextStyle(color: R.colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                          const Text('22/6/2021  -  09:21 PM',style: TextStyle(color: Color(0xFF28527A),fontSize: 14,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis risus mi. ',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500,height: 1.5),),
                    ],
                  ),
                );
           }),
         ),
         
        ],
      ),
    );
  }
}