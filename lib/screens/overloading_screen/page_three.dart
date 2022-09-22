import 'package:flutter/material.dart';
import 'package:skin_app/constants.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 170.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset('assets/products.png'),
            ),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
              child: const Text(
                textAlign: TextAlign.center,
                'Meet Your Match: Get Pumped',
                style: TextStyle(
                   fontFamily: 'Gilroy_Bold',
                    fontSize: 25,
                    color: mainColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child:const  Text(
                  style: TextStyle(fontSize: 18, color: secColor,  fontFamily: 'Gilroy_Medium'),
                  textAlign: TextAlign.center,
                  'The analysis is done — our system will identify the best  products based on your skin type and problems.'),
            ),
          ],
        ),
      ),
    );
  }
}
