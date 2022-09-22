import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:skin_app/constants.dart';
import 'package:skin_app/models/product_model.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/home.dart';
import 'package:skin_app/screens/splash_screen/intro_splash.dart';

class NointerNet extends StatelessWidget {
  const NointerNet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 300,
            width: 200,
            child: Image.asset(
              'assets/connection.png',
              color: mainColor,
            )),
        const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            'No internet connection',
            style: TextStyle(
                color: mainColor,
                letterSpacing: 0.5,
                fontFamily: 'Gilroy_Medium',
                fontWeight: FontWeight.bold,
                fontSize: 27),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            'Please check your internet connection and try agian.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: secColor,
                letterSpacing: 0.5,
                fontFamily: 'Gilroy_Medium',
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(30)),
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const SplashScreen()));
                },
                child: const Text(
                  'Try again',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontFamily: 'Gilroy_Medium',
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ))),
      ],
    );
  }

  Future loadDataFromServer(context) async {
    const url =
        'https://skin-app-db-7eb42-default-rtdb.firebaseio.com/PRODUCTS.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData =
          (json.decode(response.body)) as Map<String, dynamic>;
      extractedData.forEach((proId, data) {
        Provider.of<ProductsProvider>(context, listen: false).loadData(Product(
            name: data['name'],
            title: data['title'],
            description: data['description'],
            price: data['price'].toString(),
            imageUrl: data['imageUrl'],
            id: proId,
            apply: data['apply'],
            size: data['size'],
            category: data['category'],
            skin: data['skinType'],
            expiry: data['expiry'],
            type: data['type']));
      });

      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      Provider.of<ProductsProvider>(context, listen: false).faceWashList();
    } catch (e) {
      rethrow;
    }
  }
}
