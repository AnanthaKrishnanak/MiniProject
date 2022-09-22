import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/models/category_model.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/shop_all.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  List<Category> categories = [
    Category(
        title: 'ALL',
        subtitile: 'Nivea, Boitique, Olay..',
        imageUrl: 'assets/all-removebg.png'),
    Category(
        title: 'WOMEN',
        subtitile: 'moisturiser, toner, eyecream..',
        imageUrl: 'assets/women-removebg.png'),
    Category(
        title: 'MEN',
        subtitile: 'moisturiser, facewash..',
        imageUrl: 'assets/mens-removebg-preview.png'),
    Category(
        title: 'FACEWASH',
        subtitile: 'Nivea, Boitique, Olay..',
        imageUrl: 'assets/facewash.png'),
    Category(
        title: 'MOISTURISER',
        subtitile: 'Nivea, Boitique, Olay..',
        imageUrl: 'assets/mos-removebg-preview.png'),
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .findCat(index);

                    Get.to(const ShopScreen(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 700));
                  },
                  child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.1, color: secColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 140,
                              height: 190,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  categories[index].imageUrl.toString(),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index].title.toString(),
                                style:const TextStyle(
                                    color: mainColor,
                                    fontSize: 22,
                                    letterSpacing: .7,
                                  fontFamily: 'Gilroy_Bold'),
                              ),
                              Text(
                                categories[index].subtitile.toString(),
                                style:const TextStyle(fontFamily: 'Gilroy_Medium',color: mainColor),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      )),
                ),
              )),
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: categories.length),
    );
  }
}
