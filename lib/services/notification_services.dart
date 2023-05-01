

import 'dart:io';
import 'dart:math';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase_notifications/message_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

import '../src/baseview/Invoices/invoice_details.dart';
import '../src/baseview/Invoices/invoice_list.dart';
import '../src/baseview/base_controller.dart';
import '../src/baseview/members/chat/view/chat_view.dart';


class NotificationServices {

  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();

  // function to request notifications permissions
  void requestNotificationPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true ,
      announcement: true ,
      badge: true ,
      carPlay:  true ,
      criticalAlert: true ,
      provisional: true ,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }else {
     // AppSettings.openNotificationSettings();
      print('user denied permission');
    }
  }


  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInitializationSettings = const DarwinInitializationSettings();
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
        // onDidReceiveLocalNotification: onDidReceiveLocalNotification()
        );

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
         iOS: initializationSettingsIOS
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onSelectNotification: (payload){
          // handle interaction when app is active for android
          handleMessage(context, message);
      }
    );
  }

//   void onDidReceiveLocalNotification(
//     int id, String title, String body, String payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: Get.context!,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();

//             // await Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => SecondScreen(payload),
//             //   ),
//             // );
//           },
//         )
//       ],
//     ),
//   );
// }

  void firebaseInit(BuildContext context){


    FirebaseMessaging.onMessage.listen((message) {
      
      debugPrint("herrrrrrrrrrrrrrrrrr");
      debugPrint(message.data.toString());
      debugPrint(message.notification.toString());
      
    //   RemoteNotification? notification = message.notification ;
    //   // AndroidNotification? android = message.notification?.android ;
      
    //   if (kDebugMode) {
    //     print("notifications title:${notification?.title}");
    //     print("notifications body:${notification?.body}");
    //     // print('count:${android!.count}');
    //     print('data:${message.data.toString()}');
    //   }
    initLocalNotifications(context,message);  
    showNotification(message);
    });
  }


  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
       Random.secure().nextInt(100000).toString(),
      "High Importance Notification" ,
      importance: Importance.max  ,
      showBadge: true ,
    );

     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString() ,
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high ,
      ticker: 'ticker' ,
    //  icon: largeIconPath
    );

    // const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
    //   presentAlert: true ,
    //   presentBadge: true ,
    //   presentSound: true
    // ) ;
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(threadIdentifier: 'thread_id');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
       iOS: iOSPlatformChannelSpecifics
    );
    
    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString() ?? '',
          message.notification?.body.toString() ?? '',
          notificationDetails);
    });

  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }


  void handleMessage(BuildContext context, RemoteMessage message) {
     print(message.notification.toString());
    // print(message.notification?.body.toString());
    // print(message.data.toString());
    
    // Get.to(() => const InvoiceListScreen());

    if(message.data['type'] =='simple_invoice_add' || message.data['type'] == "custom_invoice_add"){
    //   var bNavCon = Get.find<MyBottomNavigationController>();
    // bNavCon.changeTabIndex(3);
    Get.to(() => InvoiceDetails(id: message.data['ref_id'], invoiceNum: message.data['ref_id'], reverse: true,  ) );
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => MessageScreen(
      //       id: message.data['id'] ,
      //     )));
    }
    if(message.data['type'] =='chat'){
    //   var bNavCon = Get.find<MyBottomNavigationController>();
    // bNavCon.changeTabIndex(3);
     Get.to(() => ChatScreen(title: message.data['title'],email: message.data['email'],
                                        otherUserPhoto: message.data['otherUserPhoto'] ?? '',
                                        curretUserPhoto: message.data['curretUserPhoto'] ?? '',
                                        userFcm: message.data['userFcm']  ,
                                        currentFcm: message.data['currentFcm'],
                                        ));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => MessageScreen(
      //       id: message.data['id'] ,
      //     )));
    }
  }


}