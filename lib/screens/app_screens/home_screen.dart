import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/analysis_screens/quiz.dart';
import 'package:skin_app/screens/app_screens/product_details.dart';
import 'package:skin_app/screens/app_screens/shop_all.dart';
import 'package:skin_app/screens/blog/blog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? mainColor : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  List catogerylist = ["Start Quiz", "Shop Now", "Read Articles"];
  List catogeryimage = [
    "assets/quizicon.png",
    "assets/odr.png",
    "assets/information.png",
  ];
  List screen = const [QuizScreen(), ShopScreen(), BlogScreen()];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: height / 25),
          Row(
            children: [
              SizedBox(width: width / 20),
              GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: SizedBox(
                      height: height / 30,
                      child: Image.asset(
                        "assets/hamburger.png",
                        color: Colors.black,
                      ))),
            ],
          ),
          SizedBox(height: height / 50),
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              children: [
                PageView(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Container(
                        color: Colors.transparent,
                        child: Image.asset("assets/sl1.png")),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset("assets/sl1.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset("assets/sl1.png"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: height / 4.2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator()),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: height / 50),
          catogery(height, width),
          SizedBox(height: height / 50),
          Row(
            children: [
              SizedBox(
                width: width / 20,
              ),
              Text(
                'Articles',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: size.height * 0.025,
                  fontFamily: 'Gilroy_Bold',
                ),
              ),
            ],
          ),
          SizedBox(height: height / 50),
          SizedBox(
            height: 250,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Get.to(const BlogScreen(),
                            transition: Transition.cupertino,
                            duration: const Duration(milliseconds: 400));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.4)),
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          width: width / 2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: Image.asset(
                                    Provider.of<ProductsProvider>(context)
                                        .blogs[index]
                                        .imgurl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 18.0, left: 5, right: 5),
                                  child: Text(
                                      Provider.of<ProductsProvider>(context)
                                          .blogs[index]
                                          .heading,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: mainColor,
                                        fontSize: 14,
                                        fontFamily: "Gilroy_Bold",
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: Provider.of<ProductsProvider>(context).blogs.length),
          ),
          SizedBox(height: height / 50),
          Row(
            children: [
              SizedBox(
                width: width / 20,
              ),
              Text(
                'Recommendation',
                style: TextStyle(
                    fontFamily: 'Gilroy_Bold',
                    color: Colors.black,
                    fontSize: size.height * 0.025),
              ),
            ],
          ),
          SizedBox(height: height / 50),
          Recommendation(
            height: height,
            width: width,
            index: 0,
          ),
          Recommendation(
            height: height,
            width: width,
            index: 1,
          ),
          Recommendation(
            height: height,
            width: width,
            index: 2,
          ),
          Recommendation(
            height: height,
            width: width,
            index: 3,
          ),
          Recommendation(
            height: height,
            width: width,
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget catogery(height, width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width / 20),
      child: Container(
        color: Colors.transparent,
        height: height / 17,
        width: width,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: catogerylist.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(screen[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: height / 25,
                  // width: width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width / 25),
                          child: Image.asset(catogeryimage[index],
                              height: height / 45),
                        ),
                        SizedBox(width: width / 50),
                        Padding(
                          padding: EdgeInsets.only(right: width / 25),
                          child: Text(
                            catogerylist[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gilroy_Bold',
                                fontSize: height / 65),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Recommendation extends StatelessWidget {
  const Recommendation(
      {Key? key,
      required this.height,
      required this.width,
      required this.index})
      : super(key: key);

  final double height;
  final double width;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<ProductsProvider>(context, listen: false).findIndex(
              Provider.of<ProductsProvider>(context, listen: false)
                  .faceWash[index]
                  .id);
          Get.to(
              ProductDetailScreen(
                  Provider.of<ProductsProvider>(context, listen: false)
                      .faceWash[index]
                      .id),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 400));
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
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.transparent,
                    height: height / 7,
                    width: width / 3.5,
                    child: Image.network(
                      Provider.of<ProductsProvider>(context)
                          .faceWash[index]
                          .imageUrl,
                      height: height / 7,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: width / 50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height / 80),
                      Text(
                        Provider.of<ProductsProvider>(context)
                            .faceWash[index]
                            .name,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontFamily: 'Gilroy_Bold'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          Provider.of<ProductsProvider>(context)
                              .faceWash[index]
                              .title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Gilroy_Medium',
                          ),
                        ),
                      ),
                      SizedBox(height: height / 80),
                      Text(
                        "₹ ${Provider.of<ProductsProvider>(context).faceWash[index].price}",
                        style: TextStyle(
                            fontFamily: 'Gilroy_Bold',
                            fontSize: height / 40,
                            color: mainColor),
                      ),
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
                              fontFamily: 'Gilroy_Medium',
                              color: Colors.grey,
                              fontSize: height / 60,
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
    );
  }
}
