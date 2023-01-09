
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: R.colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delete this budget'.tr,
                                style:
                                    TextStyle(color: R.colors.blackSecondery),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: R.colors.grey,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Reset this budget'.tr,
                                style:
                                    TextStyle(color: R.colors.blackSecondery),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.more_vert, color: R.colors.black)),
                Row(
                  children: [
                     Text('Office'.tr),
                    GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.close,
                          color: R.colors.black,
                        )),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: Get.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: R.colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Image.asset(
                                    R.images.cross,
                                    width: 30,
                                    height: 30,
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Add new Project type'.tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: R.colors.blackSecondery),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: R.colors.lightGrey),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Project Name'.tr,
                                    hintStyle: TextStyle(color: R.colors.grey),
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              customSimpleButton(() {
                                Get.back();
                              })
                            ],
                          ),
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: R.colors.black),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: R.colors.white),
                            padding: const EdgeInsets.all(5),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'New budget'.tr,
                            style: TextStyle(
                              color: R.colors.white,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Spacer(),
                  ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          margin: const EdgeInsets.only(left: 2),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == 1
                                  ? R.colors.blue.withOpacity(0.2)
                                  : null),
                          child: Container(
                            height: 80,
                            padding: const EdgeInsets.all(20),
                            //margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: R.colors.blue, width: 3),
                              color: R.colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Office'),
                                Text('#1'),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: R.colors.blue, width: 1),
                                color: R.colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Center(
                                child: Text(
                              '\$1413',
                              style: TextStyle(color: R.colors.blue),
                            )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'مأكولات ومشروبات',
                            style: TextStyle(color: R.colors.blackSecondery),
                          )
                        ],
                      );
                    })),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.42,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: R.colors.grey, width: 1)),
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Office - QR code',
                        style: TextStyle(color: R.colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Username #1',
                        style: TextStyle(color: R.colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '053677443 #1',
                        style: TextStyle(color: R.colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: Get.width * 0.46,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: R.colors.grey, width: 1)),
                        child: Row(
                          children: [
                            Image.asset(
                              R.images.icon2,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Total Invoices'.tr,
                                  style: TextStyle(color: R.colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total Expenses'.tr,
                                  style: TextStyle(color: R.colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: R.colors.grey, width: 1)),
                        child: Row(
                          children: [
                            Image.asset(
                              R.images.icon1,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Share Report'.tr,
                                  style: TextStyle(color: R.colors.black),
                                ),
                                
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: R.colors.grey, width: 1)),
                        child: Row(
                          children: [
                            Image.asset(
                              R.images.icon3,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                               
                                Text(
                                  'Share QR code'.tr,
                                  style: TextStyle(color: R.colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  InkWell customSimpleButton(Function()? onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: R.colors.themeColor),
        child: Center(
            child: Text(
          'Add'.tr,
          style: TextStyle(color: R.colors.white),
        )),
      ),
    );
  }
}
