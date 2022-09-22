import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/place_order.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  String id;
  ProductDetailScreen(this.id);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _controller = PageController();

  String userId = 'userId';

  Color col = Colors.red;

  @override
  Widget build(BuildContext context) {
    int i = 0;

    final size = MediaQuery.of(context).size;
    int index = Provider.of<ProductsProvider>(context).index - 1;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          elevation: 1,
          title: const Text(
            'Product details',
            style: TextStyle(
              color: mainColor,
              fontSize: 20,
              fontFamily: 'Gilroy_Bold',
            ),
          ),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: (() => Navigator.of(context).pop()),
            child: const Icon(
              EvaIcons.arrowBackOutline,
              color: mainColor,
            ),
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    height: size.height * 0.36,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  style: const TextStyle(
                                    color: mainColor,
                                    fontSize: 14,
                                    fontFamily: 'Gilroy_Bold',
                                  ),
                                  text: Provider.of<ProductsProvider>(context,
                                          listen: true)
                                      .loadedData[index]
                                      .name),
                              const TextSpan(text: '\t'),
                              TextSpan(
                                  style: const TextStyle(
                                      color: mainColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  text: Provider.of<ProductsProvider>(context)
                                      .loadedData[index]
                                      .title),
                            ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  width: double.infinity,
                                  height: size.height * 0.28,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        PageView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          controller: _controller,
                                          children: [
                                            Image.network(
                                                Provider.of<ProductsProvider>(
                                                        context)
                                                    .loadedData[index]
                                                    .imageUrl),
                                            Image.network(
                                                Provider.of<ProductsProvider>(
                                                        context)
                                                    .loadedData[index]
                                                    .imageUrl),
                                            Image.network(
                                                Provider.of<ProductsProvider>(
                                                        context)
                                                    .loadedData[index]
                                                    .imageUrl),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: SmoothPageIndicator(
                                            controller: _controller,
                                            count: 3,
                                            effect: const WormEffect(
                                                dotHeight: 10,
                                                dotWidth: 10,
                                                dotColor: Colors.black38,
                                                activeDotColor: mainColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ]),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 15,
                          fontFamily: 'Gilroy_Bold',
                        ),
                        text: 'Skin type: '),
                    TextSpan(
                        style: const TextStyle(
                          color: mainColor,
                          fontSize: 17,
                          fontFamily: 'Gilroy_Medium',
                        ),
                        text: Provider.of<ProductsProvider>(context)
                            .loadedData[index]
                            .skin)
                  ])),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: 'Qty: ',
                              style: TextStyle(
                                fontFamily: 'Gilroy_Medium',
                                color: mainColor,
                                fontSize: 20,
                              )),
                          TextSpan(
                              style: const TextStyle(
                                color: mainColor,
                                fontSize: 20,
                                fontFamily: 'Gilroy_Bold',
                              ),
                              text:
                                  '${Provider.of<ProductsProvider>(context).loadedData[index].size}g')
                        ])),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              sizewidget(
                                index: i,
                                price: Provider.of<ProductsProvider>(context)
                                    .loadedData[index]
                                    .price,
                                size: Provider.of<ProductsProvider>(context)
                                    .loadedData[index]
                                    .size,
                                stock: 'In stock',
                                col: Colors.green,
                              ),
                              sizewidget(
                                price: Provider.of<ProductsProvider>(context)
                                    .loadedData[index]
                                    .price,
                                index: i,
                                size: '200',
                                stock: 'Out of stock',
                                col: Colors.red,
                              ),
                              sizewidget(
                                price: Provider.of<ProductsProvider>(context)
                                    .loadedData[index]
                                    .price,
                                index: i,
                                size: '250',
                                stock: 'Out of stock',
                                col: Colors.red,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 20, right: 8, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product details:',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontFamily: 'Gilroy_Bold',
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Gilroy_Medium',
                              color: mainColor,
                            ),
                            text:
                                '\n${Provider.of<ProductsProvider>(context).loadedData[index].description}')
                      ]))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        minWidth: 10,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () => showwishlistdialogue(index),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(360)),
                            width: 43,
                            height: 43,
                            child: const Icon(Iconsax.heart, color: mainColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: MaterialButton(
                            color: mainColor,
                            onPressed: () {
                              showdialogue(index);
                            },
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                fontFamily: 'Gilroy_Medium',
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 20, right: 8, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How to apply:',
                        style: TextStyle(
                          fontFamily: 'Gilroy_Bold',
                          color: mainColor,
                          fontSize: 20,
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            style: const TextStyle(
                              fontFamily: 'Gilroy_Medium',
                              color: mainColor,
                            ),
                            text:
                                '\n${Provider.of<ProductsProvider>(context).loadedData[index].apply}')
                      ]))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Divider(
                    color: secColor,
                    thickness: 0.2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(17),
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Gilroy_Bold',
                          color: mainColor,
                          fontSize: 18,
                        ),
                        text: 'Expiry date: '),
                    TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Gilroy_Medium',
                          color: mainColor,
                          fontSize: 16,
                        ),
                        text: Provider.of<ProductsProvider>(context)
                            .loadedData[index]
                            .expiry)
                  ])),
                ),
              ]),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        color: Colors.white,
        child: SizedBox(
          width: size.width * 0.7,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: MaterialButton(
              color: mainColor,
              onPressed: () {
                Get.to(PlaceOrder(index),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 400));
              },
              child: Text(
                'Check out - ₹ ${Provider.of<ProductsProvider>(context).loadedData[index].price}',
                style: const TextStyle(
                  fontFamily: 'Gilroy_Bold',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addtocart(i, context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final id = sharedPref.getString(userId);
    const url = 'https://cart-94f94-default-rtdb.firebaseio.com/.json';
    await http.post(Uri.parse(url),
        body: json.encode({
          'userid': id,
          'proid': Provider.of<ProductsProvider>(context, listen: false)
              .loadedData[i]
              .id,
        }));
  }

  Future<void> addtowhishlist(i, context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final id = sharedPref.getString(userId);
    const url = 'https://wish-f2654-default-rtdb.firebaseio.com/.json';
    await http.post(Uri.parse(url),
        body: json.encode({
          'userid': id,
          'proid': Provider.of<ProductsProvider>(context, listen: false)
              .loadedData[i]
              .id,
        }));
  }

  void showdialogue(int index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: const Text(
                  'Add item to cart',
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: 'Gilroy_Medium',
                      fontSize: 24),
                ),
                actions: [
                  MaterialButton(
                      textColor: mainColor,
                      onPressed: () {
                        Provider.of<ProductsProvider>(context, listen: false).calcTotalM(
                            int.parse(Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .cartItems[index]
                                .price));
                        addtocart(index, context);
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: 'Gilroy_Bold',
                            fontSize: 27),
                      ))
                ]));
  }

  void showwishlistdialogue(int index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: const Text(
                  'Add item to wishlist',
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: 'Gilroy_Medium',
                      fontSize: 24),
                ),
                actions: [
                  MaterialButton(
                      textColor: mainColor,
                      onPressed: () {
                        addtowhishlist(index, context);
                        Navigator.pop(ctx);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: mainColor,
                            fontFamily: 'Gilroy_Bold',
                            fontSize: 27),
                      ))
                ]));
  }
}

// ignore: camel_case_types
class sizewidget extends StatelessWidget {
  const sizewidget(
      {Key? key,
      required this.price,
      required this.index,
      required this.size,
      required this.col,
      required this.stock})
      : super(key: key);

  final int index;
  final String size;
  final String stock;
  final Color col;
  final price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: 140,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: mainColor),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8),
              child: Text('$size g',
                  style: const TextStyle(
                    color: mainColor,
                    fontSize: 18,
                    fontFamily: 'Gilroy_Bold',
                  )),
            ),
            Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '₹ $price\n ',
                          style: const TextStyle(
                            color: mainColor,
                            fontFamily: 'Gilroy_Bold',
                            fontSize: 15,
                          )),
                      const TextSpan(
                          text: '(',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 15,
                          )),
                      TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Gilroy_Medium',
                            color: mainColor,
                            fontSize: 15,
                          ),
                          text:
                              ((int.parse(Provider.of<ProductsProvider>(context)
                                                  .loadedData[index]
                                                  .price) *
                                              1 /
                                              int.parse(size) *
                                              100)
                                          .round() +
                                      .27)
                                  .toString()),
                      const TextSpan(
                          text: '/ 100g )',
                          style: TextStyle(
                            fontFamily: 'Gilroy_Medium',
                            color: mainColor,
                            fontSize: 15,
                          )),
                      TextSpan(
                          text: '\n$stock',
                          style: TextStyle(
                            fontFamily: 'Gilroy_Medium',
                            color: col,
                            fontSize: 15,
                          )),
                    ])),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
