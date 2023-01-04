import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Icon(Icons.more_vert),
               Row(
                children:  [
                  const Text('Office'),
                  GestureDetector(
                    onTap: (){},
                    child: const Icon(Icons.close)),
                ],
               )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),),
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.add,size: 15,),),
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
}