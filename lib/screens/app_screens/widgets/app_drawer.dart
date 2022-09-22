import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_app/screens/analysis_screens/quiz.dart';
import 'package:skin_app/screens/blog/blog.dart';
import 'package:skin_app/screens/order_screen/order.dart';

import '../../../constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Container(
          color: Colors.white,
          child: Column(children: [
            AppBar(
              toolbarHeight: 80,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: [
                Builder(builder: (context) {
                  return GestureDetector(
                      onTap: () => Scaffold.of(context).closeDrawer(),
                      child: SizedBox(
                          width: 16,
                          height: 16,
                          child: Image.asset(
                              'assets/arrowfront-removebg-preview.png')));
                }),
                const SizedBox(
                  width: 30,
                )
              ],
              title: const  Text(
                'Skin Care',
                style: TextStyle(
                    color: mainColor,
                 
                    fontSize: 20,
                  fontFamily: 'Gilroy_Bold',
                    letterSpacing: 0.3),
              ),
            ),
            drawerMethod(
                path: 'assets/data-removebg-preview.png',
                title: 'Previous records'),
            GestureDetector(
                onTap: () => Get.to(const BlogScreen(),
                    transition: Transition.cupertino),
                child:
                    drawerMethod(path: 'assets/hamburger.png', title: 'Blog')),
            GestureDetector(
              onTap: () {
              
                Get.to(const OrderScreen(), transition: Transition.cupertino);
              },
              child: drawerMethod(
                  path: 'assets/box-removebg-preview.png', title: 'Orders'),
            ),
            GestureDetector(
                onTap: () {
                  Get.to(const QuizScreen(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 400));
                },
                child: drawerMethod(
                    path: 'assets/quiz-removebg-preview.png',
                    title: 'Take a quiz')),
          ]),
        ));
  }

  Padding drawerMethod({required path, required title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1, color: secColor),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: SizedBox(width: 28, height: 30, child: Image.asset(path)),
          title: Text(
            title,
            style: const TextStyle(
              color: mainColor,
             fontFamily: 'Gilroy_Medium',
             
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
