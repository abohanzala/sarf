import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/members/members_controller.dart';
import 'package:sarf/model/members/city_list_model.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  MembersController ctr = Get.find<MembersController>();
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
          Expanded(child: FutureBuilder<CityList?>(
            future: ctr.getCityList(),
            builder: (contaxt,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child:SizedBox(height: 100,width: 100,child: CircularProgressIndicator(color: R.colors.blue),));
              }
              if(snapshot.hasData){
                
                List<SingleCity?> data = snapshot.data!.data!.toList();
                if(data.isNotEmpty){
                 return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      
                    ),
                    itemCount: data.length,
                     itemBuilder: (context,index){
                      var singleCity = data[index];
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
                                Text("${GetStorage().read('lang') == 'en' ? singleCity?.name?.en ?? '' : singleCity?.name?.ar ?? ''} ",style: TextStyle(color: R.colors.black,fontSize: 16),),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.groups,color: R.colors.themeColor,),
                                        const SizedBox(width: 5,),
                                        Text(singleCity!.membersCount.toString(),style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
                                        const SizedBox(width: 2,),
                                        Text('Members'.tr,style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
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
              });
                }
              }
              return Center(child:Text('No Data'));
            })
          
          
          
              
              ),
        ],
      ),
    );
  }

  
  
}

