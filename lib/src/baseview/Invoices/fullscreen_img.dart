

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import "package:get/get.dart";
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


import '../../../resources/resources.dart';

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
  int _progress = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
      
      if(progress< 100){
        setState(() {
       
          
          _progress = progress;
      
        
      });
      }
      if(progress == 100){
         setState(() {
       
          
          _progress = 0;
      
        
      });
      }
    });
  }

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
                    try {
                      
                            debugPrint(_progress.toString());
                             var imageId = await ImageDownloader.downloadImage(widget.url,destination: AndroidDestinationType.directoryDownloads..subDirectory("Sarf/${widget.singleAttach}") );
                                if (imageId == null) {
                                          return;
                                  }                
                               var fileName = await ImageDownloader.findName(imageId);
                               var path = await ImageDownloader.findPath(imageId);
                               var size = await ImageDownloader.findByteSize(imageId);
                               var mimeType = await ImageDownloader.findMimeType(imageId);
                              //  Get.snackbar("Success".tr, "Downloaded to gall");                                         
                                } on PlatformException catch (error) {
                                                                        
                                        debugPrint(error.toString());
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