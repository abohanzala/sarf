import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/members/members_controller.dart';
import 'package:sarf/model/members/members_list_model.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  MembersController ctr = Get.put<MembersController>(MembersController());
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar('Members List'.tr,false,false,'',false),
          appbarSearch(),
         // const SizedBox(height: 10,),
          Expanded(child: FutureBuilder<MembersList?>(
            future: ctr.getMembersList(),
            builder: (contaxt,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child:SizedBox(height: 100,width: 100,child: CircularProgressIndicator(color: R.colors.blue),));
              }
              if(snapshot.hasData){
                
                List<SingleMember?> data = snapshot.data!.data!.toList();
                if(data.isNotEmpty){
                 return GridView.builder(
                  
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      
                    ),
                    itemCount: data.length,
                     itemBuilder: (context,index){
                      var singleData = data[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesName.cityList);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            decoration: BoxDecoration(
                             // borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border(left: BorderSide(color: R.colors.lightBlue3,width: 5)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Type'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12),),
                                const SizedBox(height: 5,),
                                Text("${GetStorage().read('lang') == 'en' ? singleData?.expenseName ?? '' : singleData?.expenseNameAr ?? ''} " ,style: TextStyle(color: R.colors.black,fontSize: 16),),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.groups,color: R.colors.themeColor,),
                                        const SizedBox(width: 5,),
                                        Text(singleData!.membersCount.toString(),style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
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
            }),
          
          // GridView.builder(
          //           padding: const EdgeInsets.symmetric(horizontal: 12),
          //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //             maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          //             childAspectRatio: 1.8,
          //             mainAxisSpacing: 15,
          //             crossAxisSpacing: 10,
                      
          //           ),
          //           itemCount: 30,
          //            itemBuilder: (context,index){
          //             return ClipRRect(
          //               borderRadius: BorderRadius.circular(10),
          //               child: GestureDetector(
          //                 onTap: (){
          //                   Get.toNamed(RoutesName.cityList);
          //                 },
          //                 child: Container(
          //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          //                   decoration: BoxDecoration(
          //                    // borderRadius: BorderRadius.circular(10),
          //                     color: Colors.white,
          //                     border: Border(left: BorderSide(color: R.colors.lightBlue3,width: 5)),
          //                   ),
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text('Type'.tr,style: TextStyle(color: R.colors.grey,fontSize: 12),),
          //                       const SizedBox(height: 5,),
          //                       Text('مأكولات ومشروبات',style: TextStyle(color: R.colors.black,fontSize: 16),),
          //                       const SizedBox(height: 5,),
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Icon(Icons.groups,color: R.colors.themeColor,),
          //                               SizedBox(width: 5,),
          //                               Text('25 Members',style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
          //                             ],
          //                           ),
          //                           Icon(Icons.arrow_forward_ios,color: R.colors.black,size: 15,),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //     }),
              ),
        ],
      ),
    );
  }
}