import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarf/constant/api_links.dart';
import 'package:sarf/src/baseview/members/chat/controller/chat_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../../resources/resources.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String email;
  final String otherUserPhoto;
  const ChatScreen({super.key, required this.title, required this.email,required this.otherUserPhoto});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();
   String chatId = '';
   String currentUser = '';
   String chatUser = '';
   bool showMoreOptions = false;
   String messageType = 'text';
   ScrollController scrollController =  ScrollController();
   bool isRecorderInit = false;
   bool isRecording = false;
   File? image;
   FlutterSoundRecorder? _soundRecorder;
   ChatController ctr = Get.put<ChatController>(ChatController());

  @override
  void initState() {
    getData();
    _soundRecorder = FlutterSoundRecorder();
    openSound();
    super.initState();
  }
  void getData() {
    currentUser = GetStorage().read('mobile');
    chatUser = widget.email;
    chatId = chatID(int.parse(currentUser), int.parse(chatUser));
    print(int.parse(currentUser));
    print(int.parse(chatUser));
    print(chatId);
  }

  String chatID(int currentID, int userID){
  if (currentID > userID ) {
    return '$userID$currentID';
  }

  return '$currentID$userID';

 }

 openSound() async{
  final status = await Permission.microphone.request();
  if (status !=  PermissionStatus.granted ) {
    throw RecordingPermissionException('Mic not allowed');
  }
  await _soundRecorder!.openRecorder();
  setState(() {
    isRecorderInit = true;
  });
  

 }

 recordSound() async{

  

  var tempDirectory = await getTemporaryDirectory();
  var path = '${tempDirectory.path}/flutter_sound';

  if (!isRecorderInit) {
        return;
      }
 if (isRecording) {
        await _soundRecorder!.stopRecorder();
       sendAudioFile(File(path));
        
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
 }

 @override
 void dispose() {
    scrollController.dispose();
    _soundRecorder!.closeRecorder();
    super.dispose();
    isRecorderInit = false;
  }

 sendMessage() async{
  print("here");
  if (image != null) {
    messageType = 'image';
  }
  
  else{
    messageType = 'text';
  }
  if (messageType == 'text') {
    if (message.text == '') {
      return;
    }
    final String msg = message.text;
    message.clear();
    FocusScope.of(context).unfocus();
      await FirebaseFirestore.instance.collection('chatroom').doc(chatId).collection('chats').add({
        'sender' : currentUser,
        'message' : msg,
        'messageType': messageType,
        'time' : DateTime.now().toIso8601String(),
      });
  }
  if (messageType == 'image') {
    sendImageFile();
  }
    //scrollController.jumpTo(scrollController.position.maxScrollExtent);

 }
 void sendImageFile() async{
  debugPrint('here');

  //image = null;
  debugPrint(image.toString());

    await ctr.uploadFirebaseFile(image!,'${const Uuid().v1()}.jpg').then((value) async{
      //print("photo----------$value");
      if(value != ''){
         await FirebaseFirestore.instance.collection('chatroom').doc(chatId).collection('chats').add({
        'sender' : currentUser,
        'message' : "${ApiLinks.assetBasePath}$value",
        'messageType': messageType,
        'time' : DateTime.now().toIso8601String(),
      }).then((value){
        image = null;
      }).catchError((error){
        debugPrint(error.toString());
      });
      }
      if(value == ''){
        Get.snackbar("Error", 'Something went wrong try later');
      }
      image = null;
      
    });
    // final ref = FirebaseStorage.instance.ref().child('chatsImages').child('${const Uuid().v1()}.jpg');

    // await ref.putFile(image!).whenComplete(() {});
    // await ref.getDownloadURL().then((value) async{
    //   //debugPrint(value);
    //   await FirebaseFirestore.instance.collection('chatroom').doc(chatRoomID).collection('chats').add({
    //     'sender' : currentID,
    //     'message' : value,
    //     'messageType': messageType,
    //     'time' : DateTime.now().toIso8601String(),
    //   }).then((value){
    //     image = null;
    //   });
      
    // });
 }


 void sendAudioFile(File file) async{
  debugPrint('here');
  messageType = 'audio';
  await ctr.uploadFirebaseFile(file,const Uuid().v1()).then((value) async{
      //print("photo----------$value");
      if(value != ''){
         await FirebaseFirestore.instance.collection('chatroom').doc(chatId).collection('chats').add({
        'sender' : currentUser,
        'message' : "${ApiLinks.assetBasePath}$value",
        'messageType': messageType,
        'time' : DateTime.now().toIso8601String(),
      }).then((value){
        // image = null;
      }).catchError((error){
        debugPrint(error.toString());
      });
      }
      if(value == ''){
        Get.snackbar("Error", 'Something went wrong try later');
      }
      // image = null;
      
    });
  //  messageType = 'audio';
  
  //   final ref = FirebaseStorage.instance.ref().child('chatsAudios').child(const Uuid().v1());

  //   await ref.putFile(file).whenComplete(() {});
  //   await ref.getDownloadURL().then((value) async{
  //   debugPrint(value);
  //     await FirebaseFirestore.instance.collection('chatroom').doc(chatRoomID).collection('chats').add({
  //       'sender' : currentID,
  //       'message' : value,
  //       'messageType': messageType,
  //       'time' : DateTime.now().toIso8601String(),
  //     });
      
  //   });
 }

 Future pickImage(String scr) async {
    
    try {
     final pickedImage = await ImagePicker().pickImage(source: scr == 'camera'? ImageSource.camera : ImageSource.gallery);
      
      if(pickedImage == null) return;

      setState(() {
        image = File(pickedImage.path);
      });
      sendMessage();
    } on PlatformException catch(e) {
      debugPrint('Failed to pick image: $e');
    }
  }

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
          Expanded(child:
          StreamBuilder(
                stream: FirebaseFirestore.instance.collection('chatroom').doc(chatId).collection('chats').orderBy('time', descending: false).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    if (data.isNotEmpty) {
                    SchedulerBinding.instance.addPostFrameCallback((_){
                      scrollController.animateTo(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                        scrollController.position.maxScrollExtent);
                    });   
                  return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: data.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Object?> singleData = data[index];
                  
                          return  MessageBox(isMe: currentUser == singleData['sender'] ? true : false, message: singleData['message'], time: singleData['time'].toString(),messageType : singleData['messageType'].toString(),otherUserPhoto: widget.otherUserPhoto, );
                      },
                );
                            }
                  }
                  return const Center(child: Text('No data'));
              })
          //  ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 6,
          //   itemBuilder: (context,index){
          //     return  MessageBox(isMe: index%2 == 0 ? true : false );
          // })
          ),
          const SizedBox(height: 10,),
          if(showMoreOptions)
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
                    GestureDetector(
                      onTap: (){
                        pickImage('camera');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt,color: R.colors.white,),
                          const SizedBox(width: 5,),
                          Text('Camera'.tr,style: TextStyle(color: R.colors.white,fontSize: 14),),
                    
                        ],
                      ),
                    ),
                    const SizedBox(width: 8,),
                    GestureDetector(
                      onTap: (){
                        pickImage('gallery');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera,color: R.colors.white,),
                          const SizedBox(width: 5,),
                          Text('Gallery'.tr,style: TextStyle(color: R.colors.white,fontSize: 14),),
                    
                        ],
                      ),
                    ),
                    
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      showMoreOptions = false;
                    });
                  },
                  child: Icon(Icons.close,color: R.colors.white,)),
              ],
            ),  
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      showMoreOptions = true;
                    });
                  },
                  child: Icon(Icons.add,color: R.colors.blue,)),
                const SizedBox(width: 5,),
                Expanded(child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: R.colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(4) ,bottomLeft: Radius.circular(4))
                  ),
                  child: TextFormField(
                    controller: message,
                    decoration:  InputDecoration(
                      hintText: 'Write something'.tr,
                      border: InputBorder.none,
                       ),
                  ),
                )),
                GestureDetector(
                  onTap: (){
                    sendMessage();
                  },
                  child: Container(
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
                ),
                const SizedBox(width: 15,),

                GestureDetector(
                  onTap: recordSound,
                  child: Container(
                    height: 40,
                    
                    decoration: BoxDecoration(
                      color: R.colors.blue,
                      borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Center(child: isRecording == true ?  Icon(
                           Icons.pause_circle,
                          color: R.colors.white,
                          size: 20,
                          
                        ) :  Icon(
                           Icons.mic,
                          color: R.colors.white,
                          size: 20,
                          
                        ),),
                  ),
                ),

              ],
            ),
          ),
        ],
      )),
    );
  }
}

class MessageBox extends StatefulWidget {
 final bool isMe;
 final String message;
 final String otherUserPhoto;
  final String time;
  final String messageType ;
  const MessageBox({super.key, required this.isMe, required this.message, required this.time, required this.messageType, required this.otherUserPhoto});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(widget.time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: widget.isMe? MainAxisAlignment.end: MainAxisAlignment.start,
      children: [
        Container(
          width: Get.width * 0.70,
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
          child: widget.isMe ? Row(
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
                      if(widget.messageType == 'image' )
                      SizedBox(
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(imageUrl: widget.message,fit: BoxFit.fill,width: Get.width,))),
                      if(widget.messageType == 'audio')
                      GestureDetector(
                                onTap: ()async{
                                  
                                   if(isPlaying == true){
                                                                     

                                    await audioPlayer.pause();
                                    isPlaying = false;
                                    setState((){
                                      
                                      
                                    });
                                    return;
                                  }

                                  if(isPlaying == false){
                                                                    
                                     await audioPlayer.play(UrlSource(widget.message));
                                      isPlaying = true;
                                     setState((){
                                      
                                    });
                                   
                                  } 
                                  audioPlayer.onPlayerStateChanged.listen((event) { 
                                    if(event.toString() == 'PlayerState.completed'){
                                      isPlaying = false;
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                  
                                },
                                child: Center(child: Icon(isPlaying == false? Icons.play_circle : Icons.pause_circle ,color:R.colors.black , )),
                              ),      
                      if(widget.messageType == 'text')
                      Text(widget.message,style: TextStyle(color: R.colors.white,fontSize: 14),),
                      const SizedBox(height: 8,),
                      Text(outputDate,
                        // DateFormat("yyyy-MM-dd hh:mm").parse(DateTime.parse(time).toString()).toString(),
                        style: TextStyle(color: R.colors.white,fontSize: 10),)
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
                      if(widget.messageType == 'image' )
                      SizedBox(
                            height: 120,
                            child: CachedNetworkImage(imageUrl: widget.message,)),
                      if(widget.messageType == 'audio')
                      GestureDetector(
                                onTap: ()async{
                                  
                                   if(isPlaying == true){
                                                                     

                                    await audioPlayer.pause();
                                    isPlaying = false;
                                    setState((){
                                      
                                      
                                    });
                                    return;
                                  }

                                  if(isPlaying == false){
                                                                    
                                     await audioPlayer.play(UrlSource(widget.message));
                                      isPlaying = true;
                                     setState((){
                                      
                                    });
                                   
                                  } 
                                  audioPlayer.onPlayerStateChanged.listen((event) { 
                                    if(event.toString() == 'PlayerState.completed'){
                                      isPlaying = false;
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                  
                                },
                                child: Center(child: Icon(isPlaying == false? Icons.play_circle : Icons.pause_circle ,color:R.colors.black , )),
                              ),      
                      if(widget.messageType == 'text')
                      Text(widget.message,style: TextStyle(color: R.colors.white,fontSize: 14),),
                      const SizedBox(height: 8,),
                      Text(outputDate,
                        // DateFormat("yyyy-MM-dd hh:mm:ss").parse(time).toString(),
                        style: TextStyle(color: R.colors.white,fontSize: 10),)
                    ],
                  ), 
                     
                  ),
                  
              ),
              const SizedBox(width: 8,),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: R.colors.grey,
                  // backgroundImage: NetworkImage(wiotherUserPhoto),
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