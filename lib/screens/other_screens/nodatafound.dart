import 'package:flutter/material.dart';


class NoOrderDataFound extends StatelessWidget {
  const NoOrderDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
          
          height: 150,
          width: 150,
          child: Image.asset('assets/noorders-removebg-preview.png')),
        const Text('You\'ve no Orders', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 27,))
      ]),
    );
  }
}
