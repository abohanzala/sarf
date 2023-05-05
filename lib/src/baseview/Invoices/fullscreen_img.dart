

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import "package:get/get.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;


import '../../../resources/resources.dart';
import '../../widgets/loader.dart';

class FullScreenView extends StatefulWidget {
  final String url;
  final String tag;
  final String singleAttach;
  const FullScreenView({Key? key, required this.url, required this.tag, required this.singleAttach}) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.black,
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: widget.tag,
              child: Screenshot(
                controller: screenshotController,
                child: Image.network(
                  widget.url,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding
          (
            padding: const EdgeInsetsDirectional.only(bottom: 20),
            child: Row(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () async{
                     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                                              if(Platform.isAndroid){
                                                 AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                                              // final status = await Permission.camera.request();
                                               final status2 = androidInfo.version.sdkInt < 33 ? await Permission.storage.request() : await Permission.photos.request()  ;
                                              // print(status);
                                              // print(status2);
                                              if(status2 == PermissionStatus.granted ){
                                                openLoader();
                                                    final dir = (await getApplicationDocumentsDirectory()).path;

                                                    // Create an image name
                                                    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                                                          final imagePath = '$dir/$fileName.png';
                                                     try{
                                                      await Dio().download(widget.url, imagePath);
                                                      await GallerySaver.saveImage(imagePath,toDcim: true);
                                                     Get.back();
                                                     Get.snackbar("Notice".tr, "Saved in gallery".tr,backgroundColor: R.colors.white);

                                                     } catch(error){
                                                      Get.back();
                                                      debugPrint(error.toString());
                                                       Get.snackbar("Error".tr, error.toString(),backgroundColor: R.colors.white);
                                                     }     
                                                        

                                                // try{
                                                //    final http.Response response = await http.get(Uri.parse(widget.url));

                                                //     // Get temporary directory
                                                //     final dir = (await getApplicationDocumentsDirectory()).path;

                                                //     // Create an image name
                                                //     String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                                                //           final imagePath = await File('$dir/$fileName.png').create();
                                                //           await imagePath.writeAsBytes(response.bodyBytes);
                                                //           await GallerySaver.saveImage(imagePath.path,toDcim: true);
                                                //           Get.back();
                                                //           Get.snackbar("Alert".tr, "Saved in gallery".tr,backgroundColor: R.colors.white);
                                                // } catch (error){
                                                //   debugPrint(error.toString());
                                                //   Get.back();
                                                //   Get.snackbar("Alert".tr, error.toString(),backgroundColor: R.colors.white);
                                                // }

                                               
    // await file.writeAsBytes(response.bodyBytes);

                  //   try {
                      
                  //           debugPrint(_progress.toString());
                  //            var imageId = await ImageDownloader.downloadImage(widget.url,destination: AndroidDestinationType.directoryDownloads..subDirectory("Sarf/${widget.singleAttach}") ).catchError((error){
                  //             Get.back();
                  //             Get.snackbar("Alert".tr, error.toString());
                  //            });
                  //               if (imageId == null) {

                  //                 Get.back();
                  //                  Get.snackbar("Alert".tr, "Saved in gallery".tr);
                  //                         return;
                  //                 } 
                  //                 Get.back();
                  //                 Get.snackbar("Alert".tr, "Saved in gallery".tr,backgroundColor: R.colors.white);               
                  //              var fileName = await ImageDownloader.findName(imageId);
                  //              var path = await ImageDownloader.findPath(imageId);
                  //              var size = await ImageDownloader.findByteSize(imageId);
                  //              var mimeType = await ImageDownloader.findMimeType(imageId);
                  //             //  Get.snackbar("Success".tr, "Downloaded to gall");                                         
                  //               } on PlatformException catch (error) {
                                         
                  //                          Get.back();
                  //                          Get.snackbar("Alert".tr, error.toString(),backgroundColor: R.colors.white);                             
                  //                       debugPrint(error.toString());
                  //                }
                  //                             }else{
                  //                               openAppSettings();
                  //                               // Get.snackbar("Error".tr, "Permission not granted");
                                               }
                                              
                    
                   }
                  },
                  child: Center(child: Text("Download".tr,style: TextStyle(color: R.colors.white),)),)),
                 
                 Expanded(child: GestureDetector(
                  onTap: () async{
                    
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        try {
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          final imagePath = await File('$directory/$fileName.png').create();
          await imagePath.writeAsBytes(image);

          final pdf = pw.Document();

          final pdfImage = pw.MemoryImage(
  File(imagePath.path).readAsBytesSync(),
);

pdf.addPage(pw.Page(
  pageFormat: PdfPageFormat.a4,
  build: (pw.Context context) {
  return pw.Center(
    child: pw.Image(pdfImage),
  ); // Center
})); // Page
         
   final output = await getTemporaryDirectory();
   String fileName2 = DateTime.now().microsecondsSinceEpoch.toString();
   final file = File("${output.path}/$fileName2.pdf");
// final file = File("example.pdf");
await file.writeAsBytes(await pdf.save());
   

          // final file = File("example.pdf");
          // await file.writeAsBytes(await pdf.save());
          // ignore: deprecated_member_use
          Share.shareXFiles([XFile(file.path)]);
        } catch (error) {
          debugPrint(error.toString());
        }
      }
    }).catchError((onError) {
      debugPrint('Error --->> $onError');
    });
  
                  },
                  child: Center(child: Text("Share".tr,style: TextStyle(color: R.colors.white),)),)),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}