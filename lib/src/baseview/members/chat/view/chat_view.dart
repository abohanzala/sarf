import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../resources/resources.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey,
      body: SafeArea(child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),

            child: Row(
              children: [
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
                  Text(widget.title,style: TextStyle(color: R.colors.black,fontSize: 16),),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(child: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context,index){
              return  MessageBox(isMe: index%2 == 0 ? true : false );
          })),
          const SizedBox(height: 10,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: R.colors.grey 
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.camera_alt,color: R.colors.white,),
                        const SizedBox(width: 5,),
                        Text('Camera'.tr,style: TextStyle(color: R.colors.white,fontSize: 14),),

                      ],
                    ),
                    const SizedBox(width: 8,),
                    Row(
                      children: [
                        Icon(Icons.camera,color: R.colors.white,),
                        const SizedBox(width: 5,),
                        Text('Gallery'.tr,style: TextStyle(color: R.colors.white,fontSize: 14),),

                      ],
                    ),
                    
                  ],
                ),
                Icon(Icons.close,color: R.colors.white,),
              ],
            ),  
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            child: Row(
              children: [
                Icon(Icons.add,color: R.colors.blue,),
                const SizedBox(width: 5,),
                Expanded(child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: R.colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(4) ,bottomLeft: Radius.circular(4))
                  ),
                  child: TextFormField(
                    decoration:  InputDecoration(
                      hintText: 'Write something'.tr,
                      border: InputBorder.none,
                       ),
                  ),
                )),
                Container(
                  height: 40,
                  
                  decoration: BoxDecoration(
                    color: R.colors.blue,
                    borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Transform.rotate(
                      angle: -120,
                      child: Center(child: Icon(Icons.send,color: R.colors.white,size: 20,))),
                ),
                const SizedBox(width: 15,),

                Container(
                  height: 40,
                  
                  decoration: BoxDecoration(
                    color: R.colors.blue,
                    borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(child: Icon(Icons.mic,color: R.colors.white,size: 20,)),
                ),

              ],
            ),
          ),
        ],
      )),
    );
  }
}

class MessageBox extends StatelessWidget {
 final bool isMe;
  const MessageBox({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe? MainAxisAlignment.start: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width * 0.70,
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
          child: isMe ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: R.colors.grey,
                ),

                const SizedBox(width: 8,),

              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: R.colors.blue,
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello',style: TextStyle(color: R.colors.white,fontSize: 14),),
                      const SizedBox(height: 8,),
                      Text('Today 09:29 AM',style: TextStyle(color: R.colors.white,fontSize: 10),)
                    ],
                  ),    
                  ),
              )

            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: R.colors.themeColor,
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello',style: TextStyle(color: R.colors.white,fontSize: 14),),
                      const SizedBox(height: 8,),
                      Text('Today 09:29 AM',style: TextStyle(color: R.colors.white,fontSize: 10),)
                    ],
                  ), 
                     
                  ),
                  
              ),
              const SizedBox(width: 8,),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: R.colors.grey,
                ),

                

            ],
          ),
        )  
      ],
    );
    // return Align(
    //   alignment:  Alignment.centerRight,
    //   child: Container(
        
    //    // width: Get.width * 0.70,
       
    //    margin: EdgeInsets.only(right: 50.w),
    //    //color: R.colors.black,
    //     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //      // mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         CircleAvatar(
    //           radius: 20,
    //           backgroundColor: R.colors.grey,
    //         ),
    //         const SizedBox(width: 8,),
    //         Expanded(
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(8),
    //               color: R.colors.blue,
    //                ),
    //            child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text('Hello',style: TextStyle(color: R.colors.white,fontSize: 14),),
    //               const SizedBox(height: 8,),
    //               Text('Today 09:29 AM',style: TextStyle(color: R.colors.white,fontSize: 10),)
    //             ],
    //            ),    
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}