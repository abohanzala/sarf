import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sarf/controllers/viewers/viewers_controller.dart';
import 'package:sarf/src/baseview/members/chat/view/chat_view.dart';
import 'package:sarf/src/baseview/more/add_new_user.dart';

import '../../../resources/resources.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  // ViewersController ctr = Get.put<ViewersController>(ViewersController());
  final messageCollection = FirebaseFirestore.instance.collection('messages');
  final userId = GetStorage().read('mobile');
  TextEditingController searchValue = TextEditingController();
  Timer? searchOnStoppedTyping;

  bool isSearch = false;


  


  _onChangeHandler(value ) {
    searchValue.selection = TextSelection.collapsed(offset: searchValue.text.length);
        const duration = Duration(milliseconds:1000); // set the duration that you want call search() after that.
        if (searchOnStoppedTyping != null) {
            setState(() => searchOnStoppedTyping?.cancel()); // clear timer
        }
        setState(() => searchOnStoppedTyping =  Timer(duration, (){ 
          
          
          search(value);
          
          }));
    }

    search(value) {
      // setState(() {
      //    membersLenght = '(0)';
      // });
       FocusScope.of(context).unfocus();
        //print('hello world from search . the value is $value');
        if(value.isEmpty){
          setState(() {
            isSearch = false;
          });
            return;
          
        }

        setState(() {
          isSearch = true;
        });


            
                
              }

  @override
  void dispose() {
    searchOnStoppedTyping?.cancel();
    super.dispose();
  }            

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.lightGrey ,
      body: SafeArea(child: 
       Column(children: [
          Container(
              padding: EdgeInsets.only(left: GetStorage().read("lang") == 'en'?  16.w : 0, top: 5.h,right: GetStorage().read("lang") == 'en'? 0:16.w ),
              height: 80.h,
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
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: GetStorage().read('lang') == 'en' ? Alignment.centerLeft : Alignment.centerRight,
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
                Text(
                  'Chat'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4,),

            Transform(
              transform: Matrix4.translationValues(0, -20, 0),
              child: Container(
                              //margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Container(
                                height: 50,
                                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: R.colors.lightBlue2,
                                border: Border.all(color: R.colors.lightBlue,width: 1) ),
                                child:
                                TextFormField(
                                  onTap: (){
                                    searchValue.selection = TextSelection.collapsed(offset: searchValue.text.length);
                                  },
                                  controller: searchValue,
                                  onChanged: _onChangeHandler,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(bottom: 5),
                                    hintText: 'Search here'.tr,
                                    hintStyle: TextStyle(color: R.colors.grey),
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                              
                                  ),
                                ),
                              ),
                            ),
            ),
                          // const SizedBox(height: 10,),
            
            Expanded(child: Column(
              children: [
                
                Expanded(
                  child: isSearch == true ? StreamBuilder<QuerySnapshot>(
                              stream:  messageCollection.where( userId.toString(), isEqualTo: true).snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),),
            );
                                }
                                
                                if(snapshot.hasData){
                                  final messages = snapshot.data?.docs.where((element) => 
                              element[GetStorage().read('name').toString() == element['chatUserName'].toString() ? "currentUserName" : "chatUserName" ].contains(RegExp(searchValue.text, caseSensitive: false)) == true ).toList();
                                  if(messages == null || messages.isEmpty ){
                                    return Center(child:Text('No Data'.tr,style: TextStyle(color: R.colors.black)));
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // primary: false,
                                    itemCount: messages.length,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      var message = messages[index];
                                      final name = GetStorage().read('name').toString() == message['chatUserName'].toString() ? message['currentUserName'].toString() : message['chatUserName'].toString();
                                      final currentFcm =  message['currentFcm'].toString() ;
                                      final userFcm =  message['userFcm'].toString();
                                      final otherUserPhoto =  message['otherUserPhoto'].toString();
                                      final curretUserPhoto =  message['curretUserPhoto'].toString();
                                      final msg =  message['lastMessage'].toString();
                                      final msgType =  message['messageType'].toString();
                                      final id =  GetStorage().read('mobile') == message['userId'].toString() ? message['userId2'].toString() : message['userId'].toString() ;
                                      return InkWell(
              onTap: () {
                Get.to(() => ChatScreen(title: name, email: id, otherUserPhoto: otherUserPhoto, curretUserPhoto: curretUserPhoto, userFcm: userFcm, currentFcm: currentFcm) );
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                decoration: BoxDecoration(
                  color: R.colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: R.colors.grey,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 1
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: R.colors.blackSecondery,width: 1)
                          ),
                           child: otherUserPhoto != ''? CircleAvatar(radius: 25,backgroundImage: NetworkImage(otherUserPhoto),) : Container(width: 40,height: 40,)
                          // CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: AssetImage(R.images.pharmacy),
                          // ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(name,style: TextStyle(color: R.colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                           SizedBox(height: 5,),
                            Text(msgType == 'audio' ? "audio".tr : msgType == 'image' ? 'image'.tr : msg ,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: R.colors.black,fontSize: 14,),)
                          ],
                        ),
                  ],
                ),

              ),
            );
                                  });
                                }
                                return Center(child:Text('No Data'.tr,style: TextStyle(color: R.colors.black),));
                              })  : StreamBuilder<QuerySnapshot>(
                              stream:  messageCollection.where( userId.toString(), isEqualTo: true).snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(color: R.colors.blue),),),
            );
                                }
                                
                                if(snapshot.hasData){
                                  final messages = snapshot.data?.docs;
                                  if(messages == null || messages.isEmpty ){
                                    return Center(child:Text('No Data'.tr,style: TextStyle(color: R.colors.black)));
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    // primary: false,
                                    itemCount: messages.length,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      var message = messages[index];
                                      final name = GetStorage().read('name').toString() == message['chatUserName'].toString() ? message['currentUserName'].toString() : message['chatUserName'].toString();
                                      final currentFcm =  message['currentFcm'].toString() ;
                                      final userFcm =  message['userFcm'].toString();
                                      final otherUserPhoto =  message['otherUserPhoto'].toString();
                                      final curretUserPhoto =  message['curretUserPhoto'].toString();
                                      final msg =  message['lastMessage'].toString();
                                      final msgType =  message['messageType'].toString();
                                      final id =  GetStorage().read('mobile') == message['userId'].toString() ? message['userId2'].toString() : message['userId'].toString() ;
                                      return InkWell(
              onTap: () {
                Get.to(() => ChatScreen(title: name, email: id, otherUserPhoto: otherUserPhoto, curretUserPhoto: curretUserPhoto, userFcm: userFcm, currentFcm: currentFcm) );
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                decoration: BoxDecoration(
                  color: R.colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: R.colors.grey,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 1
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: R.colors.blackSecondery,width: 1)
                          ),
                           child: otherUserPhoto != ''? CircleAvatar(radius: 25,backgroundImage: NetworkImage(otherUserPhoto),) : Container(width: 40,height: 40,)
                          // CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: AssetImage(R.images.pharmacy),
                          // ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(name,style: TextStyle(color: R.colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                           SizedBox(height: 5,),
                            Text(msgType == 'audio' ? "audio".tr : msgType == 'image' ? 'image'.tr : msg ,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: R.colors.black,fontSize: 14,),)
                          ],
                        ),
                  ],
                ),

              ),
            );
                                  });
                                }
                                return Center(child:Text('No Data'.tr,style: TextStyle(color: R.colors.black),));
                              }), 
                ),
              ],
            )),
        ],),
      ),
    );
  }
}