import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skin_app/screens/app_screens/shop_all.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({Key? key}) : super(key: key);

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  void initState() {
    _navigate(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
              width: 260,
              height: 260,
              child: Lottie.asset('assets/orderplace.json')),
        ),
      ),
    );
  }

  Future<void> _navigate(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pop(MaterialPageRoute(builder: (context) =>const  ShopScreen()));
  }
}
