import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';

import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/product_details.dart';

class ItemCard extends StatelessWidget {

  int index;
  ItemCard(this.index,  {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(5),
      //  padding: const EdgeInsets.only(bottom: 1.0, right: 1),
      child: Container(
        height: size.width * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: secColor, width: 0.1),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              width: double.infinity,
              height: size.height * 0.22,
              child: Image.network(
                Provider.of<ProductsProvider>(context)
                    .loadedData[index]
                    .imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15),
              child: Text(
                Provider.of<ProductsProvider>(context).loadedData[index].title,
                style: const  TextStyle(
                  fontFamily: 'Gilroy_Bold',
                   
                    color: secColor,
                    fontSize: 18,
                   
                    ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${Provider.of<ProductsProvider>(context).loadedData[index].size}g',
                    style: const TextStyle(
                       
                        color: Colors.black54,
                        fontSize: 20,
                       fontFamily: 'Gilroy_Bold'
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '- ₹ ${Provider.of<ProductsProvider>(context).loadedData[index].price}',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    minWidth: 10,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {},
                    child: ((Provider.of<ProductsProvider>(context)
                                .loadedData[index]
                                .isFavorite ==
                            false)
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(360)),
                            width: 43,
                            height: 43,
                            child: const Icon(
                              EvaIcons.heartOutline,
                              color: Color.fromARGB(255, 255, 31, 15),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(360)),
                            width: 43,
                            height: 43,
                            child: const Icon(
                              EvaIcons.heart,
                              color: secColor,
                            ),
                          ))),
                MaterialButton(
                  shape: const StadiumBorder(),
                  color: mainColor,
                  minWidth: size.width * 0.2,
                  height: 30,
                    onPressed: () {
                                    Get.to(ProductDetailScreen( Provider.of<ProductsProvider>(context, listen: false)
                                      .moisturizerData[index].id),
                                        transition: Transition.zoom,
                                        duration:
                                            const Duration(milliseconds: 400));
                                  },
                  child: const Icon(
                    EvaIcons.shoppingBagOutline,
                    color: white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
