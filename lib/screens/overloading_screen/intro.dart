import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/screens/login_screen/login.dart';
import 'package:skin_app/screens/overloading_screen/page_one.dart';
import 'package:skin_app/screens/overloading_screen/page_three.dart';
import 'package:skin_app/screens/overloading_screen/page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:skin_app/constants.dart';

const showOverLoading = 'ShowOverloading';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;


  @override
  Widget build(BuildContext context) {
    final length = MediaQuery.of(context).size.height;
    final defaultPadding = length * 0.040;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [PageOne(), PageTwo(), PageThree()],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: Colors.black38,
                    activeDotColor: mainColor),
              ),
              onLastPage
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              top: defaultPadding),
                          child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {},
                                  child: const SizedBox())),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              top: 6,
                              bottom: defaultPadding),
                          child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: .001, color: Colors.black12)),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  setShared();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginScreen())));
                                },
                                child: const Text(
                                  'Get started',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy_Bold'),
                                ),
                              )),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              top: defaultPadding),
                          child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child:const  Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy_Bold'),
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              top: 6,
                              bottom: defaultPadding),
                          child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(width: .9, color: secColor)),
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  _controller.jumpToPage(2);
                                },
                                child:const  Text(
                                  'Skip',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 20,
                                       fontFamily: 'Gilroy_Bold'),
                                ),
                              )),
                        ),
                      ],
                    ),
            ],
          )
        ]),
      ),
    );
  }

  Future<void> setShared() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(showOverLoading, false);
  }
}
