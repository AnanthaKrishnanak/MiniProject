
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';

import 'package:skin_app/providers/product.dart';

class BlogOne extends StatelessWidget {
  final int index;
  const BlogOne({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 70,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,
                    color: Colors.black, size: height / 30),
              ),
              pinned: true,
              expandedHeight: height / 2.8,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.only(right: 38.0),
                    child: Text(
                      Provider.of<ProductsProvider>(context)
                          .blogs[index]
                          .heading,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2D2D3A),
                          fontSize: 17,
                          fontFamily: 'Gilroy_Bold'),
                    ),
                  ),
                  background: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      Provider.of<ProductsProvider>(context)
                          .blogs[index]
                          .imgurl,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(children: [
                      SizedBox(
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                                child: Text(
                                    Provider.of<ProductsProvider>(context)
                                        .blogs[index]
                                        .heading,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Gilroy_Bold',
                                      color: Color(0xff2D2D3A),
                                      fontSize: 20,
                                    ))),
                            WidgetSpan(
                                child: Text(
                                    Provider.of<ProductsProvider>(context)
                                        .blogs[index]
                                        .subtitle,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: mainColor,
                                      fontSize: 17,
                                    ))),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh1,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c1,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Color(0xff2D2D3A),
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh2,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c2,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: mainColor,
                                    fontFamily: 'Gilroy_Medium',
                                    fontSize: 17,
                                  ))),
                        ]),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      Provider.of<ProductsProvider>(context)
                          .blogs[index]
                          .imgurl2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(children: [
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh3,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c3,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh4,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c4,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh5,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c5,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh6,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c6,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh7,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c7,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh8,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c8,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .sh9,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Bold',
                                    color: mainColor,
                                    fontSize: 20,
                                  ))),
                          WidgetSpan(
                              child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .c9,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Gilroy_Medium',
                                    color: mainColor,
                                    fontSize: 17,
                                  ))),
                        ]),
                      )
                    ]),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
