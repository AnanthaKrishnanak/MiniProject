import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/models/product_model.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/home.dart';
import 'package:skin_app/screens/login_screen/login.dart';
import 'package:skin_app/screens/overloading_screen/intro.dart';

const showOverLoading = 'ShowOverloading';
const showlogin = 'showlogin';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    loadDataFromServer();

    _navigate();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final sharedPref = await SharedPreferences.getInstance();
    final check = sharedPref.getBool(showOverLoading);
    final islogedin = sharedPref.getBool(showlogin);
    checkDataLoaded();

    if (check == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const IntroScreen()));
    }
    if (check == false) {
      if (islogedin == false) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/splash.json')),
    );
  }

  Future loadDataFromServer() async {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkDataLoaded() async {
    if (Provider.of<ProductsProvider>(context, listen: false).loadedData.isEmpty) {
      Provider.of<ProductsProvider>(context, listen: false).dataloaded(false);
    }
  }
}
