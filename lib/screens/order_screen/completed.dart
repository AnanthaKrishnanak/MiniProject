import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';

import '../../providers/product.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.1, color: secColor)),
                padding: const EdgeInsets.all(20),
                height: size.height * 0.2,
                child: Row(children: [
                  Image.network(
                    Provider.of<ProductsProvider>(context)
                        .userOrderList[index]
                        .imageUrl,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Provider.of<ProductsProvider>(context)
                            .userOrderList[index]
                            .name,
                        style: const TextStyle(
                          fontFamily: 'Gilroy_Bold',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        Provider.of<ProductsProvider>(context)
                            .userOrderList[index]
                            .type,
                        style: const TextStyle(
                          fontFamily: 'Gilroy_Medium',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '₹ ${Provider.of<ProductsProvider>(context).userOrderList[index].price}',
                        style: const TextStyle(
                          color: mainColor,
                          fontFamily: 'Gilroy_Bold',
                          fontSize: 22,
                        ),
                      ),
                      const Text(
                        'Delivered',
                        style: TextStyle(
                          fontFamily: 'Gilroy_Bold',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ]),
              ),
            )),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 1);
  }
}
