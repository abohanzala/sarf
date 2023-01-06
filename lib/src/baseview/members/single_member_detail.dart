import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarf/src/baseview/members/chat/view/chat_view.dart';
import 'package:sarf/src/utils/routes_name.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';

class SingleMemberDetails extends StatefulWidget {
  final String title;
  const SingleMemberDetails({super.key, required this.title});

  @override
  State<SingleMemberDetails> createState() => _SingleMemberDetailsState();
}

class _SingleMemberDetailsState extends State<SingleMemberDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar(widget.title,true,false,'',false),
          //appbarSearch(),
          //const SizedBox(height: 10,),
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
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(R.images.pharmacy),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('White Pharmacy',style: TextStyle(color: R.colors.black,fontSize: 16),),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Text('Invoices',style: TextStyle(color: R.colors.grey,fontSize: 14),),
                              const SizedBox(width: 10,),
                              Text('250',style: TextStyle(color: R.colors.black,fontSize: 14),),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text('Amounts',style: TextStyle(color: R.colors.grey,fontSize: 14),),
                              const SizedBox(width: 10,),
                              Text('350000',style: TextStyle(color: R.colors.black,fontSize: 14),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Divider(
                            color: R.colors.grey,
                            thickness: 1,
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Row(
                                children: [
                                  Icon(Icons.location_on_sharp,size: 20,color: R.colors.black,),
                                  const SizedBox(width: 8,),
                                  Flexible(
                                    child: Text('lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
                                    style:TextStyle(color: R.colors.black,fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )),
                              const SizedBox(width: 3,),
                              Row(
                                children: [
                                  Text('Directions',
                                    style:TextStyle(color: R.colors.themeColor,fontSize: 14,fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 5,),
                                    Icon(Icons.directions,color: R.colors.themeColor,size: 20,),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
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
                                onTap: () => Get.to(() => const ChatScreen(title: 'Name')),
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
                ),
         ),
         const SizedBox(height: 10,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Title for the list below',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
              Row(children: [
                Image.asset(R.images.listStack,width: 20,height: 20,),
                const SizedBox(width: 20,),
                Image.asset('assets/images/data.png',width: 20,height: 20,color: R.colors.black,),
              ],),
            ],
           ),
         ),
         const SizedBox(height: 15,),
         Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
         child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invoice No',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                  Text('12-04-2021',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                ],
              ),
              const SizedBox(height: 5,),
              Text('00',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              Text('Amount',style: TextStyle(color: R.colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
              const SizedBox(height: 5,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('00000',style: TextStyle(color: R.colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                  GestureDetector(
                    onTap: () => Get.toNamed( RoutesName.invoiceDetails ),
                    child: Text('Details',style: TextStyle(color: R.colors.themeColor,fontSize: 14,
                    decoration: TextDecoration.underline,fontWeight: FontWeight.w500,
                    ),
                    
                    ),
                  ),
                ],
              ),

            ],
          ),
         ),
         )
        ],
      ),
    );
  }
}