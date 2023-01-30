import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../resources/resources.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  buildQrView(BuildContext context) {
  return QRView(key: qrKey, onQRViewCreated: onQRViewCreated,
  overlay: QrScannerOverlayShape(
    borderColor: R.colors.blue,
    cutOutSize: Get.width * 0.80,
    borderWidth: 10,
    borderLength: 20,
    borderRadius: 10
  ),
  );
}

 void onQRViewCreated(QRViewController controller) {
setState(() => this.controller = controller);
controller.scannedDataStream.listen((barcode){
  setState((() {
this.barcode = barcode;
controller.dispose();
}));
Future.delayed(const Duration(seconds: 2),(){
Get.back();
});

});
setState(() {
controller.resumeCamera();
});
}

@override
  void reassemble() async{
    if(Platform.isAndroid){
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
    
    super.reassemble();
    
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(alignment: Alignment.center,
      children: [
        buildQrView(context),
        Positioned(
          bottom: 10,
          child: Text(barcode != null ? "Result: ${barcode?.code}": 'Scan a code'.tr,style: TextStyle(color: R.colors.blue),))
      ],
      )),
    );
  }


 
}

