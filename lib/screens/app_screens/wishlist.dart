import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:http/http.dart' as http;

import 'package:skin_app/screens/app_screens/product_details.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  var _showloading = true;
  var _start = true;
  @override
  void initState() {
    setState(() {
      _start = false;
    });
    loadorders();
    super.initState();
  }

  late ChangeNotifier fav;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    fav = Provider.of<ProductsProvider>(context);
    return Column(
      children: [
        (_start)
            ? (_showloading)
                ? (Provider.of<ProductsProvider>(context)
                        .wishlisteditems
                        .isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Provider.of<ProductsProvider>(context,
                                            listen: false)
                                        .findIndex(
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .cartItems[index]
                                                .id);
                                    Get.to(
                                        ProductDetailScreen(
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .cartItems[index]
                                                .id),
                                        transition: Transition.cupertino,
                                        duration:
                                            const Duration(milliseconds: 400));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5.0, bottom: 5.0),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 1.5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                      ),
                                      child: Container(
                                        height: height / 6.72,
                                        width: width / 1.1,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(width: width / 80),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Container(
                                                color: Colors.transparent,
                                                height: height / 7,
                                                width: width / 3.5,
                                                child: Image.network(
                                                  Provider.of<ProductsProvider>(
                                                          context)
                                                      .wishlisteditems[index]
                                                      .imageUrl,
                                                  height: height / 7,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width / 50),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: height / 80),
                                                Text(
                                                  Provider.of<ProductsProvider>(
                                                          context)
                                                      .wishlisteditems[index]
                                                      .name,
                                                  style: const TextStyle(
                                                      fontFamily: 'Gilroy_Bold',
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "₹ ${Provider.of<ProductsProvider>(context).wishlisteditems[index].price}",
                                                  style: TextStyle(
                                                      fontFamily: 'Gilroy_Bold',
                                                      fontSize: height / 30,
                                                      color: secColor),
                                                ),
                                                SizedBox(height: height / 70),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: Color(0xffFFC107),
                                                      size: 22,
                                                    ),
                                                    SizedBox(width: width / 50),
                                                    Text(
                                                      "4.7 ",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Gilroy_Medium',
                                                        color: Colors.grey,
                                                        fontSize: height / 60,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: height / 70),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/like.png',
                                                    height: height / 35,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: width / 30),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (BuildContext context, index) =>
                                const SizedBox(),
                            itemCount: Provider.of<ProductsProvider>(context)
                                .wishlisteditems
                                .length),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 98.0),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/empty_cart.png'),
                            const Text(
                              'Empty cart',
                              style: TextStyle(
                                  fontFamily: 'Gilroy_Bold',
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            )
                          ],
                        )),
                      )
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 300,
                          ),
                          CircularProgressIndicator(
                            color: mainColor,
                          )
                        ]),
                  )
            : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 300,
                      ),
                      CircularProgressIndicator(
                        color: mainColor,
                      )
                    ]),
              )
      ],
    );
  }

  Future<void> loadorders() async {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<ProductsProvider>(context, listen: false).loadwishlistitems()
          .then((value) {
        setState(() {
          _start = true;
        });
      });
    });
  }

  Future<void> removefromcart(context, index) async {
    var datapath = Provider.of<ProductsProvider>(context, listen: false)
        .cartItems[index]
        .dataid;

    var url = 'https://cart-94f94-default-rtdb.firebaseio.com/$datapath.json';

    try {
      await http.delete(Uri.parse(url)).then((value) {
        setState(() {
          Future.delayed(Duration.zero).then((value) {
            Provider.of<ProductsProvider>(context, listen: false)
                .loadcartitems()
                .then((value) {
              setState(() {
                _showloading = true;
              });
            });
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }

  void showdialogue(int index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: const Text(
                'Delete item from cart',
              ),
              content: const Text('Do you want to remove this item from cart'),
              actions: [
                MaterialButton(
                    textColor: mainColor,
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('CANCEL')),
                MaterialButton(
                    textColor: mainColor,
                    onPressed: () {
                      removefromcart(context, index);
                      setState(() {
                        _showloading = false;
                      });
                      Navigator.pop(ctx);
                    },
                    child: const Text('OK')),
              ],
            ));
  }
}
