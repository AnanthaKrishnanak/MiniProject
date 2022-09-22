import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/screens/order_screen/completed.dart';
import 'package:skin_app/screens/order_screen/order_pages.dart';
import '../../providers/product.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int index = 0;
  bool isEmpty = true;
  final pages = [const OrderPage(), const CompletedPage()];
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => {getordersfromdb()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Order Summary',
              style: TextStyle(
                  color: mainColor,
                  fontFamily: 'Gilroy_Bold',
                  letterSpacing: 0.6,
              ),
            ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                EvaIcons.arrowBackOutline,
                color: mainColor,
              ),
            )),
        body: 
             pages[index],
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
            height: size.height * 0.08,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 221, 221, 221),
                          spreadRadius: 1,
                          blurRadius: 20)
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                      currentIndex: index,
                      onTap: (newindex) {
                        setState(() {
                          index = newindex;
                        });
                      },
                      selectedItemColor: secColor,
                      backgroundColor: Colors.grey[150],
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                            icon: (index == 0)
                                ? const Icon(
                                    Icons.timelapse_outlined,
                                    color: mainColor,
                                  )
                                : const Icon(
                                    Icons.timelapse,
                                    color: mainColor,
                                  ),
                            label: 'Orders'),
                        BottomNavigationBarItem(
                            icon: (index == 1)
                                ? const Icon(
                                    Icons.check,
                                    color: mainColor,
                                  )
                                : const Icon(
                                    Icons.check,
                                    color: mainColor,
                                  ),
                            label: 'Completed'),
                      ]),
                ))));
  }

  Future<void> getordersfromdb() async {
    Provider.of<ProductsProvider>(context, listen: false).userOrderList.clear();
    Provider.of<ProductsProvider>(context, listen: false).getOrders().then((_) {
     
    });
    return;
  }
}
