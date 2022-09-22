import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/product_details.dart';
import 'package:skin_app/screens/blog/blog.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

bool showAnimation = false;

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () => set());
  }

  Future<void> set() async {
    setState(() {
      showAnimation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Results',
            style: TextStyle(
              fontFamily: 'Gilroy_Bold',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
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
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
        ),
        body: showAnimation
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: width / 20,
                            ),
                            Text(
                              'Your skin profile',
                              style: TextStyle(
                                  fontFamily: 'Gilroy_Bold',
                                  color: Colors.black,
                                  fontSize: height * 0.025),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width / 20, right: width / 20),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                  child: Text(
                                Provider.of<ProductsProvider>(context)
                                    .resultexplanations[0],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontFamily: 'Gilroy_Medium',
                                  color: Color(0xff3d3d4e),
                                  fontSize: 17,
                                ),
                              )),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          'Recommendations',
                          style: TextStyle(
                              fontFamily: 'Gilroy_Bold',
                              color: Colors.black,
                              fontSize: height * 0.025),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Provider.of<ProductsProvider>(context,
                                          listen: false)
                                      .findIndex(Provider.of<ProductsProvider>(
                                              context,
                                              listen: false)
                                          .result[index]
                                          .id);
                                  Get.to(
                                      ProductDetailScreen(
                                          Provider.of<ProductsProvider>(context,
                                                  listen: false)
                                              .result[index]
                                              .id),
                                      transition: Transition.cupertino,
                                      duration:
                                          const Duration(milliseconds: 400));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, bottom: 10),
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(0.1),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.1, color: secColor),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30)),
                                        child: Image.network(
                                          Provider.of<ProductsProvider>(context,
                                                  listen: false)
                                              .result[index]
                                              .imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: Provider.of<ProductsProvider>(context)
                              .result
                              .length),
                    ),
                    SizedBox(height: height / 50),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width / 20, right: width / 20),
                      child: const Divider(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          'Know more',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: height * 0.025,
                            fontFamily: 'Gilroy_Bold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    SizedBox(
                      height: 250,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Get.to(const BlogScreen(),
                                      transition: Transition.cupertino,
                                      duration:
                                          const Duration(milliseconds: 400));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.4)),
                                      color: Colors.transparent,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                    ),
                                    width: width / 2,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: [
                                          SizedBox(
                                            height: 300,
                                            child: Image.asset(
                                              Provider.of<ProductsProvider>(
                                                      context)
                                                  .blogs[index]
                                                  .imgurl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 18.0,
                                                left: 5,
                                                right: 5),
                                            child: Text(
                                                Provider.of<ProductsProvider>(
                                                        context)
                                                    .blogs[index]
                                                    .heading,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Gilroy_Bold",
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(),
                          itemCount: Provider.of<ProductsProvider>(context)
                              .blogs
                              .length),
                    ),
                    SizedBox(height: height / 50),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator(color: mainColor)));
  }
}
