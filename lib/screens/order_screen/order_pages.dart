import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var showloading = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (showloading)
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.1, color: secColor)),
                    padding: const EdgeInsets.all(20),
                    height: size.height * 0.2,
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Image.network(Provider.of<ProductsProvider>(context)
                          .userOrderList[index]
                          .imageUrl, fit: BoxFit.cover,),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Provider.of<ProductsProvider>(context)
                                .userOrderList[index]
                                .name,
                            style: const TextStyle( fontFamily: 'Gilroy_Bold',
                              color: mainColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            Provider.of<ProductsProvider>(context)
                                .userOrderList[index]
                                .type,
                            style: const TextStyle( fontFamily: 'Gilroy_Medium',
                              color: mainColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '₹ ${Provider.of<ProductsProvider>(context).userOrderList[index].price}',
                            style: const TextStyle(
                              color: mainColor,
                              fontSize: 20,
                               fontFamily: 'Gilroy_Bold',
                            ),
                          ),
                          Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.grey)),
                              child: MaterialButton(
                                onPressed: () {
                                  showdialogue(index, context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style:  TextStyle(color: Colors.grey, fontFamily: 'Gilroy_Medium',),
                                ),
                              ))
                        ],
                      )   , const SizedBox(width: 40,)
                    ]),
                  ),
                )),
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount:
                Provider.of<ProductsProvider>(context).userOrderList.length)
        : const Center(
            child: CircularProgressIndicator(
            color: mainColor,
          ));
  }

  void showdialogue(int index, context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text('Cancel order', style: const TextStyle()),
              content: Text(
                'Do you want to cancel this order',
                style: const TextStyle(),
              ),
              actions: [
                MaterialButton(
                    textColor: mainColor,
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('cancel', style: const TextStyle())),
                MaterialButton(
                    textColor: mainColor,
                    onPressed: () {
                      removefromcart(context, index);

                      Navigator.pop(ctx);
                    },
                    child: Text('OK', style: const TextStyle(fontSize: 25))),
              ],
            ));
  }

  Future<void> removefromcart(context, index) async {
    var datapath =
        Provider.of<ProductsProvider>(context, listen: false).orderpath[index];

    var url = 'https://orders-3900b-default-rtdb.firebaseio.com/$datapath.json';

    try {
      await http.delete(Uri.parse(url)).then((value) {
        Future.delayed(Duration.zero).then((value) {
          Provider.of<ProductsProvider>(context, listen: false)
              .getOrders()
              .then((_) {
            setState(() {
              showloading = true;
            });
          });
        });
      });
    } catch (error) {
      rethrow;
    }
  }
}
