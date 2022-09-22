import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/providers/product.dart';
import 'package:get/get.dart';

import 'package:skin_app/screens/splash_screen/intro_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        fontFamily: 'Gilroy_Medium'
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
