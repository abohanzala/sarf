import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar('Cites'.tr,true,false,'',false),
          appbarSearch(),
         // const SizedBox(height: 10,),
          Expanded(child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      
                    ),
                    itemCount: 30,
                     itemBuilder: (context,index){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesName.membersList);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: const BoxDecoration(
                             // borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                             // border: Border(left: BorderSide(color: R.colors.lightBlue3,width: 5)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('City'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12),),
                                const SizedBox(height: 5,),
                                Text('Madinah',style: TextStyle(color: R.colors.black,fontSize: 16),),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.groups,color: R.colors.themeColor,),
                                        const SizedBox(width: 5,),
                                        Text('25 Members',style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,color: R.colors.black,size: 15,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              })),
        ],
      ),
    );
  }

  
  
}

