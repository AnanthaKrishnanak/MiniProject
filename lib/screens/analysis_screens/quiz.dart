import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/analysis_screens/quiz_one.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

List<int> _selectedItems = <int>[];
List<String> _quizData = [
  'Oliy',
  'Dry',
  'Balanced',
  'Combination',
  'Non of the above'
];
var selected = false;

class _QuizScreenState extends State<QuizScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              EvaIcons.arrowBackOutline,
              color: Colors.black,
            )),
        toolbarHeight: 100,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(children: const [
            SizedBox(height: 10),
            Text(
              'What can we help with?',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Gilroy_Bold',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Select all that apply',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontFamily: 'Gilroy_Medium',
              ),
            )
          ]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
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
                                ? Border.all(width: 2, color: mainColor)
                                : Border.all(color: Colors.transparent)),
                        child: GestureDetector(
                            onLongPress: () {
                              if (!_selectedItems.contains(index)) {
                                setState(() {
                                  setState(() {
                                    selected = true;
                                  });
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
                                  if (_selectedItems.isEmpty) {
                                    setState(() {
                                      selected = false;
                                    });
                                  }
                                });
                              }
                            },
                            child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: mainColor, width: 0.1),
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
          child: (selected)
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 58.0, right: 58, bottom: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                        color: mainColor,
                        minWidth: 150,
                        height: 70,
                        onPressed: () {
                          addinfo();
                          setState(() {
                            selected = false;
                          });
                          _selectedItems.clear();
                          Get.to(const QuizScreenOne(),
                              transition: Transition.cupertino,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'Gilroy_Medium',
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )),
                  ),
                )
              : const SizedBox()),
    );
  }

  void addinfo() {
    for (var element in _selectedItems) {
      Provider.of<ProductsProvider>(context, listen: false)
          .getproblems(element);
    }
  }
}
