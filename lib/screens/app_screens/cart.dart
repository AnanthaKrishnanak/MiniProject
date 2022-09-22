import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/animations/orderplaced.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/place_order.dart';
import 'package:skin_app/screens/app_screens/product_details.dart';
import 'package:skin_app/screens/app_screens/shop_all.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  bool _showLoading = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      color: Colors.black, size: height / 30),
                ),
                title: Text(
                  "Cart",
                  style: TextStyle(
                    fontSize: height / 40,
                    color: Colors.black,
                    fontFamily: 'Gilroy_Bold',
                  ),
                ),
                floating: true,
                expandedHeight: height / 5,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                        padding: EdgeInsets.only(top: height / 10.0),
                        child: FlexibleSpaceBar(
                          background: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 18),
                            child: Container(
                              color: Colors.transparent,
                              height: height / 5,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      'total: ',
                                      style: TextStyle(
                                          fontSize: height / 55,
                                          fontFamily: 'Gilroy_Medium',
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "₹${Provider.of<ProductsProvider>(context).totalamount}",
                                      style: TextStyle(
                                          fontSize: height / 35,
                                          fontFamily: 'Gilroy_Bold',
                                          color: secColor),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'total items in cart: ',
                                      style: TextStyle(
                                          fontSize: height / 55,
                                          fontFamily: 'Gilroy_Medium',
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      Provider.of<ProductsProvider>(context)
                                          .cartItems
                                          .length
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: height / 50,
                                          fontFamily: 'Gilroy_Medium',
                                          color: Colors.grey),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ))),
              ),
              _showLoading
                  ? SliverList(
                      delegate: SliverChildListDelegate(List.generate(
                          Provider.of<ProductsProvider>(context)
                              .cartItems
                              .length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, bottom: 5.0),
                                child: GestureDetector(
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
                                                    .cartItems[index]
                                                    .imageUrl,
                                                height: height / 7,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width / 50),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: height / 80),
                                                Text(
                                                  Provider.of<ProductsProvider>(
                                                          context)
                                                      .cartItems[index]
                                                      .name,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'Gilroy_Bold'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Text(
                                                    Provider.of<ProductsProvider>(
                                                            context)
                                                        .cartItems[index]
                                                        .title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontFamily:
                                                          'Gilroy_Medium',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height / 80),
                                                Text(
                                                  "₹ ${Provider.of<ProductsProvider>(context).cartItems[index].price}",
                                                  style: TextStyle(
                                                      fontFamily: 'Gilroy_Bold',
                                                      fontSize: height / 40,
                                                      color: mainColor),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'move to wishlist ',
                                                      style: TextStyle(
                                                          color: secColor,
                                                          fontSize: height / 60,
                                                          fontFamily:
                                                              'Gilroy_Bold'),
                                                    ),
                                                    Text(
                                                      ' | ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: height / 60,
                                                          fontFamily:
                                                              'Gilroy_Medium'),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _showLoading = false;
                                                        });
                                                        Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .remTotalM(int.parse(
                                                                Provider.of<ProductsProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .cartItems[
                                                                        index]
                                                                    .price));
                                                        removefromcart(
                                                            context, index);
                                                      },
                                                      child: Text(
                                                        ' remove',
                                                        style: TextStyle(
                                                            color: secColor,
                                                            fontSize:
                                                                height / 60,
                                                            fontFamily:
                                                                'Gilroy_Bold'),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))))
                  : SliverToBoxAdapter(
                      child: Center(
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 100,
                          ),
                          CircularProgressIndicator(color: mainColor),
                        ],
                      ),
                    ))
            ],
          ),
        ),
        bottomNavigationBar:
            Provider.of<ProductsProvider>(context).cartItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Shop",
                          style: TextStyle(
                              fontSize: height / 55,
                              fontFamily: 'Gilroy_Bold',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextButton(
                        onPressed: () {
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const OrderPlaced())
                          );
                        },
                        child: Text(
                          "CheckOut - ₹${Provider.of<ProductsProvider>(context, listen: false).totalamount}",
                          style: TextStyle(
                              fontSize: height / 55,
                              fontFamily: 'Gilroy_Bold',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ));
  }

  Future<void> resetloading() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isloading = false;
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
                _showLoading = true;
              });
            });
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }
}
