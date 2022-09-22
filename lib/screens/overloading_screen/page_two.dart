import 'package:flutter/material.dart';
import 'package:skin_app/constants.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.asset('assets/ai.jpg'),
          ),
          Container(
            padding: const EdgeInsets.only(left: 50, bottom: 20, right: 50),
            child: const Text(
              textAlign: TextAlign.center,
              'Take a Secure Photo',
              style: TextStyle(
                  fontSize: 25,  fontFamily: 'Gilroy_Bold', color: mainColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: const Text(
              textAlign: TextAlign.center,
              'Get your instant AI skin analysis report.',
              style: TextStyle(fontSize: 18, color: secColor,  fontFamily: 'Gilroy_Medium'),
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      )),
    );
  }
}
