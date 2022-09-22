import 'package:flutter/material.dart';
import 'package:skin_app/constants.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 81.0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200, child: Image.asset("assets/5607.jpg")),
            Container(
                padding: const EdgeInsets.only(left: 50, bottom: 20, right: 50),
                child: const Text(
                    textAlign: TextAlign.center,
                    'The Kickoff: Take the Diagnostic',
                    style: TextStyle(
                        fontFamily: 'Gilroy_Bold',
                        fontSize: 25,
                        color: mainColor))),
            Container(
              padding: const EdgeInsets.only(left: 50, bottom: 20, right: 50),
              child:const  Text(
                textAlign: TextAlign.center,
                'With a few clicks, tell us about your skin and goals, and our skin analysis app will design a regimen just for you.',
                style: TextStyle(fontSize: 18, color: secColor,  fontFamily: 'Gilroy_Medium'),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
