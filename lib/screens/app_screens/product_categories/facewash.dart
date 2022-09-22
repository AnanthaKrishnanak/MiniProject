import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/product_details.dart';

class FaceWash extends StatelessWidget {
  const FaceWash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Column(
        children: [
          const Divider(
            thickness: 0.1,
            color: secColor,
          ),
          Expanded(
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    Provider.of<ProductsProvider>(context).facewashData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.57),
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Provider.of<ProductsProvider>(context, listen: false).findIndex(
                          Provider.of<ProductsProvider>(context, listen: false)
                              .facewashData[index]
                              .id);
                      Get.to(
                          ProductDetailScreen(
                              Provider.of<ProductsProvider>(context, listen: false)
                                  .facewashData[index]
                                  .id),
                          transition: Transition.zoom,
                          duration: const Duration(milliseconds: 400));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      //  padding: const EdgeInsets.only(bottom: 1.0, right: 1),
                      child: Card(
                            color: Colors.white,
                        elevation: 1.5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
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
                                height: size.height * 0.21,
                                child: Image.network(
                                  Provider.of<ProductsProvider>(context)
                                      .facewashData[index]
                                      .imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 15),
                                child: Text(
                                  Provider.of<ProductsProvider>(context)
                                      .facewashData[index]
                                      .title,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: secColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy_Medium'),
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
                                      '${Provider.of<ProductsProvider>(context).facewashData[index].size}g',
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black54,
                                          fontSize: 20,
                                          
                                          fontFamily: 'Gilroy_Medium'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '- ₹ ${Provider.of<ProductsProvider>(context).facewashData[index].price}',
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: mainColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy_Medium'),
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
                                      child: ((Provider.of<ProductsProvider>(
                                                      context)
                                                  .facewashData[index]
                                                  .isFavorite ==
                                              false)
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(360)),
                                              width: 43,
                                              height: 43,
                                              child: const Icon(
                                                EvaIcons.heartOutline,
                                                color: Color.fromARGB(
                                                    255, 255, 31, 15),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.circular(360)),
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
                                      Provider.of<ProductsProvider>(context)
                                          .findIndex(
                                              Provider.of<ProductsProvider>(
                                                      context, listen: false)
                                                  .facewashData[index]
                                                  .id);
                                      Get.to(
                                          ProductDetailScreen(
                                              Provider.of<ProductsProvider>(
                                                      context, listen: false)
                                                  .facewashData[index]
                                                  .id),
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
                      ),
                    ))),
          ),
        ],
      )
    ]);
  }
}
