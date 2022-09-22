import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skin_app/animations/orderplaced.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/models/order.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/profile_screens/addres.dart';

class PlaceOrder extends StatefulWidget {
  int index;
  PlaceOrder(this.index);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Order Summary',
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Gilroy_Medium',
              letterSpacing: 0.6,
              fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            EvaIcons.arrowBackOutline,
            color: mainColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ValueListenableBuilder(
                  valueListenable:
                      Provider.of<ProductsProvider>(context).addressadded,
                  builder: (BuildContext context, bool value, _) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.1, color: secColor),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: 'Deliver to: \n',
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                  fontFamily: 'Gilroy_Medium',
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '${Provider.of<ProductsProvider>(
                                context,
                              ).adrs.name}\n',
                              style: const TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                  fontFamily: 'Gilroy_Bold',
                                  ),
                            ),
                            TextSpan(
                                text:
                                    '${Provider.of<ProductsProvider>(context).adrs.building}\n',
                                style: const TextStyle(fontFamily: 'Gilroy_Medium',
                                    color: secColor, fontSize: 17)),
                            TextSpan(
                                text: Provider.of<ProductsProvider>(context)
                                    .adrs
                                    .area,
                                style: const TextStyle(fontFamily: 'Gilroy_Medium',
                                    color: secColor, fontSize: 17)),
                            TextSpan(
                                text:
                                    '${Provider.of<ProductsProvider>(context).adrs.landmark}\n',
                                style: const TextStyle( fontFamily: 'Gilroy_Medium',
                                    color: secColor, fontSize: 17)),
                            TextSpan(
                                text:
                                    "${Provider.of<ProductsProvider>(context).adrs.city} ${Provider.of<ProductsProvider>(context).adrs.pincode}",
                                style: const TextStyle(fontFamily: 'Gilroy_Medium',
                                    color: secColor, fontSize: 17)),
                            TextSpan(
                                text:
                                    '\n${Provider.of<ProductsProvider>(context).adrs.mobile}\n',
                                style: const TextStyle(fontFamily: 'Gilroy_Medium',
                                    color: mainColor, fontSize: 17)),
                          ])),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, bottom: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(const AddressScreen(),
                                          transition: Transition.cupertino,
                                          duration: const Duration(
                                              milliseconds: 400));
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 0.4, color: secColor),
                                          color: mainColor,
                                        ),
                                        child:  Center(
                                          child: (Provider.of<ProductsProvider>(context).adrs.building!='')?const Text(
                                            'Change address',
                                            style:  TextStyle(
                                                
                                                fontFamily: 'Gilroy_Medium',
                                                color: Colors.white,
                                                fontSize: 17),
                                          ):const Text(
                                            'Add address',
                                            style:  TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Gilroy_Medium',
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: size.height * 0.36,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.1, color: mainColor),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30))),
                        height: size.height * 0.3,
                        width: size.width * 0.46,
                        child: Image.network(
                          Provider.of<ProductsProvider>(context, listen: false)
                              .loadedData[widget.index]
                              .imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        height: size.height * 0.3,
                        width: size.width * 0.47,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              Provider.of<ProductsProvider>(context)
                                  .loadedData[widget.index]
                                  .name,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: mainColor,
                                  fontSize: 20,
                                  fontFamily: 'Gilroy_Bold',
                                ),
                            ),
                            const Divider(
                              thickness: 0.1,
                              color: secColor,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: Provider.of<ProductsProvider>(context)
                                    .loadedData[widget.index]
                                    .title,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: mainColor,
                                    fontSize: 10,
                                    fontFamily: 'Gilroy_Medium',
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                            const Divider(
                              thickness: 0.1,
                              color: secColor,
                            ),
                            Container(
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  border:
                                      Border.all(width: 0.2, color: secColor),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  '₹ ${Provider.of<ProductsProvider>(context).loadedData[widget.index].price}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Gilroy_Bold',
                                 ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: (Provider.of<ProductsProvider>(context).adrs.building!='')?Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 50,
            child: MaterialButton(
              color: mainColor,
              onPressed: () {
                addOrders(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const OrderPlaced()));
              },
              child: const Text(
                'Check out',
                style: TextStyle(
                    color: white,
                    fontSize: 22,
                    fontFamily: 'Gilroy_Bold',
                   ),
              ),
            ),
          ),
        ),
      ):Container(
        height: 10,
        color: Colors.white,
      )
    );
  }

  Future postData(order) async {
    const url =
        'https://skin-app-db-7eb42-default-rtdb.firebaseio.com/USERDATA/.json';
    try {
      http.post(
          Uri.parse(
            url,
          ),
          body: json.encode({
            'user': order.userId,
            'productId': order.productId,
            'address':
                '${Provider.of<ProductsProvider>(context).adrs.building} ,${Provider.of<ProductsProvider>(context).adrs.area} ${Provider.of<ProductsProvider>(context).adrs.name} ${Provider.of<ProductsProvider>(context).adrs.mobile} ${Provider.of<ProductsProvider>(context).adrs.landmark}  '
          }));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrders(context) async {
    final shared = await SharedPreferences.getInstance();
    var id = shared.getString('userId');
    const url = 'https://orders-3900b-default-rtdb.firebaseio.com/.json';
    try {
      await http.post(Uri.parse(url),
          body: json.encode({
            'pid': Provider.of<ProductsProvider>(context, listen: false)
                .loadedData[widget.index]
                .id,
            'user': id,
          }));
    } catch (e) {
      rethrow;
    }
  }
}
