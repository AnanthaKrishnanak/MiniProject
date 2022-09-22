import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skin_app/screens/analysis_screens/result.dart';
import '../../constants.dart';
import '../../providers/product.dart';
import 'package:http/http.dart' as http;

class QuizScreenTwo extends StatefulWidget {
  const QuizScreenTwo({Key? key}) : super(key: key);

  @override
  State<QuizScreenTwo> createState() => _QuizScreenTwoState();
}

String txt = '';
List<int> _selectedItems = <int>[];
List<String> _quizData = ['Male', 'Female', 'I\'d rather not say'];
var selected = false;
var up = 'Upload your image';

class _QuizScreenTwoState extends State<QuizScreenTwo> {
  XFile? image;
  Future<void> pickimage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        image = img;
        setState(() {
          up = 'Image uploaded';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<ProductsProvider>(context, listen: false)
                  .result
                  .clear();
            },
            child: const Icon(
              EvaIcons.arrowBackOutline,
              color: Colors.black,
            )),
        title: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(children: const [
            SizedBox(height: 10),
            Text(
              'Tell us a bit about yourself.',
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
              'What\'s your gender?',
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
            height: 20,
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
                padding: const EdgeInsets.only(top: 58.0),
                child: SizedBox(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _quizData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 40, right: 40),
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
                                    border: Border.all(
                                        color: mainColor, width: 0.1),
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
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(children: [
              Text(
                up,
                style: const TextStyle(
                    color: mainColor,
                    letterSpacing: 0.5,
                    fontFamily: 'Gilroy_Bold',
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        setState(() {});
                        pickimage();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(360)),
                          height: 70,
                          width: 70,
                          child: const Icon(
                            EvaIcons.uploadOutline,
                            color: mainColor,
                          )),
                    ),
                    Text(
                      txt,
                      style: const TextStyle(
                          color: mainColor,
                          letterSpacing: 0.5,
                          fontFamily: 'Gilroy_Bold',
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ]),
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
                        minWidth: 200,
                        height: 70,
                        onPressed: () {
                          getai('qwerty', image!);
                          setresult(context);
                          _selectedItems.clear();
                          setState(() {
                            selected = false;
                          });
                          Get.to(const ResultScreen(),
                              transition: Transition.cupertino,
                              duration: const Duration(milliseconds: 400));
                        },
                        child: const Text(
                          'GET YOUR AI REPORT',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontFamily: 'Golroy_Bold',
                              fontSize: 17),
                        )),
                  ),
                )
              : const SizedBox()),
    );
  }

  void addinfo(context) {
    for (var element in _selectedItems) {
      Provider.of<ProductsProvider>(context, listen: false).getgender(element);
    }
  }

  Future<void> getai(String text, XFile file) async {
    const url = 'http://172.30.12.108/skinapp/public/poster';

    var request = http.MultipartRequest("POST", Uri.parse(url));

    request.fields["text_field"] = text;

    var pic = await http.MultipartFile.fromPath("file_field", file.path);

    request.files.add(pic);
    var response = await request.send().timeout(
          const Duration(seconds: 3000),
        );

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if(responseString=='Pimples'){
      
             // ignore: use_build_context_synchronously
             Provider.of<ProductsProvider>(context, listen: false).addresult(
          Provider.of<ProductsProvider>(context, listen: false).loadedData[4]);
    }
  }

  void setresult(context) {
    var gender = _selectedItems[0];
       Provider.of<ProductsProvider>(context, listen: false).addresult(
          Provider.of<ProductsProvider>(context, listen: false).loadedData[12]);
             Provider.of<ProductsProvider>(context, listen: false).addresult(
          Provider.of<ProductsProvider>(context, listen: false).loadedData[10]);
    for (var probs
        in Provider.of<ProductsProvider>(context, listen: false).userProblems) {
      if (probs == 0) {
        if (gender == 0) {
          for (var i
              in Provider.of<ProductsProvider>(context, listen: false).drym) {
            Provider.of<ProductsProvider>(context, listen: false).addresult(i);
          }
        } else {
          for (var i
              in Provider.of<ProductsProvider>(context, listen: false).dryw) {
            Provider.of<ProductsProvider>(context, listen: false).addresult(i);
          }
        }
      }
    }
  }

  
}
