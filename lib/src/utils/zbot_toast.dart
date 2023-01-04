import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/resources.dart';
import '../../resources/resources.dart';

class ZBotToast {
  static loadingShow() async {
    BotToast.showCustomLoading(
        toastBuilder: (func) {
          return MyLoader(
            color: R.colors.themeColor,
          );
        },
        allowClick: false,
        clickClose: false,
        backgroundColor: Colors.transparent);
    Future.delayed(const Duration(seconds: 60), () => loadingClose());
  }

  static Future loadingClose() async {
    BotToast.cleanAll();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  static showToastSuccess(
      {@required String? message, Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: Get.height * 0.02),
                decoration: BoxDecoration(
                    color: const Color(0xff85BB65),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            message!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 3));
  }

  static showToastError({@required String? message, Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
                decoration: BoxDecoration(
                    color: const Color(0xFFE6532D),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Oops!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            message!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 2));
  }

  static showToastSomethingWentWrong({Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFFE6532D),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Oops!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(
                            'Something went wrong',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 5));
  }
}


class MyLoader extends StatefulWidget {
  final Color color;

  const MyLoader({Key? key, this.color = Colors.red}) : super(key: key);

  @override
  MyLoaderState createState() => MyLoaderState();
}

class MyLoaderState extends State<MyLoader> {
  bool loading = false;
  Timer? _timer;
  final int _start = 10;
  int? start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              inDialog('Loading timeout', true);
              loading = false;
            });
          } else {
            start = start! - 1;
            if (loading == false) {
              _timer!.cancel();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
// startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 15, sigmaY: 15, tileMode: TileMode.mirror),
        child: SpinKitPulse(color: Colors.blue,));
  }

  void inDialog(String message, bool isError) {
    Color color = isError ? Colors.redAccent : Colors.green;
    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(
            fontFamily: 'poppins',
            fontSize: Get.height * 0.0,
            fontWeight: FontWeight.bold),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: Get.height * 0.032,
              backgroundColor: color,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Get.height * 0.030,
                  child: Icon(
                    isError ? Icons.warning : Icons.done_outline,
                    color: color,
                    size: Get.height * 0.042,
                  )),
            ),
            SizedBox(
              height: Get.height * 0.016,
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'poppins', fontSize: Get.height * 0.022)),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  setState(() {
                    _timer!.cancel();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16),
                  width: Get.width * .32,
                  height: Get.height * .05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: R.colors.themeColor),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * .024),
                  ),
                ),
              )
            ],
          )
        ]);
  }
}
