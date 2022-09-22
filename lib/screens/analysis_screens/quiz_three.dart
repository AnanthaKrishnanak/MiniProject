import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/screens/analysis_screens/quiz_two.dart';
import '../../providers/product.dart';

class QuizTwo extends StatefulWidget {
  const QuizTwo({super.key});

  @override
  State<QuizTwo> createState() => _QuizTwoState();
}

class _QuizTwoState extends State<QuizTwo> {
  final List<int> _selectedItems = <int>[];
  final List<String> _quizData = const ['Gel', 'Cream'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 110,
        elevation: 0,
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              EvaIcons.arrowBackOutline,
              color: Colors.black,
            )),
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(children: [
            const SizedBox(height: 10),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Tell us a bit about yourself.                      ',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Gilroy_Bold',
                ),
              )
            ])),
            RichText(
                text: const TextSpan(children: [
              TextSpan(text: '\n'),
              TextSpan(
                text: 'When it comes to a moisturizer, are you gel, or cream?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Gilroy_Medium',
                ),
              )
            ]))
          ]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75))),
              child: Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _quizData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 40, right: 40),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: (_selectedItems.contains(index))
                                ? Border.all(width: 2, color: secColor)
                                : Border.all(color: Colors.transparent)),
                        child: GestureDetector(
                            onLongPress: () {
                              if (!_selectedItems.contains(index)) {
                                setState(() {
                                  _selectedItems.clear();
                                  _selectedItems.add(index);
                                });
                              }
                            },
                            onTap: () {
                              if (_selectedItems.contains(index)) {
                                setState(() {
                                  _selectedItems
                                      .removeWhere((val) => val == index);
                                });
                              }
                            },
                            child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: secColor, width: 0.1),
                                ),
                                child: Center(
                                    child: Text(
                                  _quizData[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Gilroy_Medium',
                                      letterSpacing: 0.5,
                                      fontSize: 19),
                                )))),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 58.0, right: 58, bottom: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: MaterialButton(
                  color: mainColor,
                  minWidth: 150,
                  height: 70,
                  onPressed: () {
             
                    Get.to(const QuizScreenTwo(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 500));
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontFamily: 'Gilroy_Bold',
                        fontSize: 19),
                  )),
            ),
          )),
    );
  }

  void setresult(context) {
    var creamOrgel = _selectedItems[0];
   
    if (creamOrgel == 0) {
             Provider.of<ProductsProvider>(context, listen:  false)
                        .gelornot(_selectedItems[0]);
      Provider.of<ProductsProvider>(context, listen: false).addresult(
          Provider.of<ProductsProvider>(context, listen: false).loadedData[10]);
    } else {
             Provider.of<ProductsProvider>(context, listen:  false)
                        .gelornot(_selectedItems[0]);
      Provider.of<ProductsProvider>(context, listen: false).addresult(
          Provider.of<ProductsProvider>(context, listen: false).loadedData[11]);
    }
  }
}
