import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/product_categories/all.dart';
import 'package:skin_app/screens/app_screens/product_categories/facewash.dart';
import 'package:skin_app/screens/app_screens/product_categories/men.dart';
import 'package:skin_app/screens/app_screens/product_categories/moisturiser.dart';
import 'package:skin_app/screens/app_screens/product_categories/women.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _pages = const [
    AllScreen(),
    WomenScreen(),
    MenScreen(),
    FaceWash(),
    MoisturizerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<ProductsProvider>(context, listen: false).cat;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Shop',
            style: TextStyle(
                fontSize: 25,
                color: mainColor,
                fontFamily: 'Gilroy_Bold',
               ),
          ),
          leading: GestureDetector(
            onTap: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .clearCat();
              Navigator.of(context).pop();
            },
            child: const SizedBox(
              height: 50,
              width: 50,
              child: Icon(
                size: 30,
                EvaIcons.arrowBackOutline,
                color: mainColor,
              ),
            ),
          )),
      body: _pages[index],
    );
  }
}
