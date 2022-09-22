import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/blog/blog1.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title:  const Text(
          'Articles',
          style:
              TextStyle(color: mainColor,  fontSize: 20,fontFamily: 'Gilroy_Bold'),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const SizedBox(
              width: 50,
              height: 60,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  EvaIcons.arrowBackOutline,
                  color: mainColor,
                ),
              ),
            )),
      ),
      body: SafeArea(
          child: SizedBox(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Get.to(
                      BlogOne(
                        index: index,
                      ),
                      transition: Transition.cupertino),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                    child: Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: [
                        Card(
                            color: Colors.white,
                            elevation: 1.5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(11),
                              ),
                            ),
                          
                            child: SizedBox(
                                height: 200,
                            width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .imgurl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .heading,
                                  style: const TextStyle(
                                      color: Color(0xff2D2D3A),
                                      fontSize: 20,
                                      fontFamily: 'Gilroy_Bold'),
                                ),
                                SizedBox(
                                  height: height / 60,
                                ),
                                Text(
                                  Provider.of<ProductsProvider>(context)
                                      .blogs[index]
                                      .subtitle,
                                  style:const TextStyle(
                                      color: Color.fromARGB(255, 133, 137, 160),
                                      fontSize: 14,
                                     fontFamily: 'Gilroy_Medium'),
                                ),
                                const SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            separatorBuilder: (BuildContext context, index) => const SizedBox(),
            itemCount: Provider.of<ProductsProvider>(context).blogs.length),
      )),
    );
  }
}
