import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/controllers/members/members_controller.dart';
import 'package:sarf/src/baseview/members/chat/view/chat_view.dart';
import 'package:sarf/src/baseview/members/single_member_detail.dart';

import '../../../model/members/members_list_new_model.dart';
import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({super.key});

  @override
  State<MembersListScreen> createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  MembersController ctr = Get.find<MembersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            customAppBar('Member List'.tr,true,true,'',false),
            appbarSearch(),
            const SizedBox(height: 10,),
            Expanded(child: FutureBuilder<ListMembersNewList?>(
            future: ctr.getMembersNewList(ctr.selectExpanseTypeID,ctr.selectCityID),
            builder: (contaxt,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child:SizedBox(height: 100,width: 100,child: CircularProgressIndicator(color: R.colors.blue),));
              }
              if(snapshot.hasData){
                
                List<Data> data = snapshot.data!.data!;
                if(data.isNotEmpty){
                 return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                var singleData = data[index];
              return Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: R.colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: R.colors.blackSecondery,width: 1)
                      ),
                      child: singleData.photo != null? Image.network("${ApiLinks.assetBasePath}${singleData.photo}") : Container(width: 40,height: 40,)
                      // CircleAvatar(
                      //   radius: 25,
                      //   backgroundImage: singleData.photo != null? Image(image: Net,)  :AssetImage(R.images.pharmacy),
                      // ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() =>  SingleMemberDetails(title: singleData.name ?? '',id: singleData.id.toString(),)),
                          child: Text(singleData.name ?? '',style: TextStyle(color: R.colors.black,fontSize: 16),)),
                        const SizedBox(height: 5,),
                        Text(singleData.userDetail?.location ?? '',style: TextStyle(color: R.colors.grey,fontSize: 12),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Text('Invoices'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14),),
                            const SizedBox(width: 10,),
                            Text(singleData.invoicesCount ?? '0',style: TextStyle(color: R.colors.black,fontSize: 14),),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('Amounts'.tr,style: TextStyle(color: R.colors.grey,fontSize: 14),),
                            const SizedBox(width: 10,),
                            Text(  singleData.invoicesSumAmount ?? '0',style: TextStyle(color: R.colors.black,fontSize: 14),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(R.images.twitter,width: 30,height: 30,),
                                const SizedBox(width: 5,),
                                Image.asset(R.images.insta,width: 30,height: 30,),
                                const SizedBox(width: 5,),
                                Image.asset(R.images.web,width: 30,height: 30,),
                                const SizedBox(width: 5,),
                                Image.asset(R.images.whatsapp,width: 30,height: 30,),
                                const SizedBox(width: 5,),
                                Image.asset(R.images.call,width: 30,height: 30,),
                                const SizedBox(width: 5,),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => ChatScreen(title: 'Name')) ,
                              child: Row(children: [
                                Text('chat',style: TextStyle(color: R.colors.themeColor,fontSize: 14),),
                                const SizedBox(width: 4,),
                                Icon(Icons.chat,color: R.colors.themeColor,size: 15,),
                              ],),
                            )
                            
                        ],)
                      ],
                    )),
                  ],
                ),
              );
            });
                }
              }
              return Center(child:Text('No Data'));
            }),
            
            
            
             
            )
            // Expanded(child: GridView.builder(
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
                              
            //                 },
            //                 child: Container(
            //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //                   decoration: const BoxDecoration(
            //                    // borderRadius: BorderRadius.circular(10),
            //                     color: Colors.white,
            //                    // border: Border(left: BorderSide(color: R.colors.lightBlue3,width: 5)),
            //                   ),
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text('City',style: TextStyle(color: R.colors.grey,fontSize: 12),),
            //                       const SizedBox(height: 5,),
            //                       Text('Madinah',style: TextStyle(color: R.colors.black,fontSize: 16),),
            //                       const SizedBox(height: 5,),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Row(
            //                             children: [
            //                               Icon(Icons.groups,color: R.colors.themeColor,),
            //                               const SizedBox(width: 5,),
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
            //     })),
          ],
        ),
      
    );
  }

  
}