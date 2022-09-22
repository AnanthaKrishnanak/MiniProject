import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/screens/app_screens/cart.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/app_screens/categories.dart';
import 'package:skin_app/screens/app_screens/wishlist.dart';
import 'package:skin_app/screens/app_screens/home_screen.dart';
import 'package:skin_app/screens/other_screens/no_internet.dart';
import 'package:skin_app/screens/profile_screens/profile.dart';
import 'package:skin_app/screens/app_screens/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _pages = [
  const Home(),
  CategoryScreen(),
  const WishListScreen(),
  ProfileScreen()
];
final _title = ['', 'Categories', 'Wishlist', ''];
String userId = 'userId';

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).faceWashList();

    Provider.of<ProductsProvider>(context, listen: false).men();

    Provider.of<ProductsProvider>(context, listen: false).women();

    Provider.of<ProductsProvider>(context, listen: false).moisturizer();
    Future.delayed(Duration.zero).then((_) => getcart());
    Provider.of<ProductsProvider>(context, listen: false).getadr();
    setorder();
    super.initState();
  }

  var showloading = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: (index == 3 || index == 0)
            ? AppBar(
                leading: const SizedBox(),
                toolbarHeight: 0,
                backgroundColor: Colors.white,
              )
            : AppBar(
                toolbarHeight: size.height * 0.1,
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  _title[index],
                  style: const TextStyle(
                      color: mainColor,
                      letterSpacing: 0.6,
                      fontFamily: 'Gilroy_Bold'),
                ),
                leading: (index == 0)
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => setState(() {
                          index = index - 1;
                        }),
                        child: const Icon(
                          EvaIcons.arrowBackOutline,
                          color: mainColor,
                        ),
                      ),
                actions: [
                  GestureDetector(
                    onTap: (() => Get.to(const Cart(),
                        transition: Transition.rightToLeft)),
                    child: Container(
                        margin: const EdgeInsets.all(16),
                        child: (index != 3 && index != 0)
                            ? Image.asset(
                                'assets/shopping-cart.png',
                                height: 10,
                                width: 25,
                              )
                            : const SizedBox()),
                  ),
                ],
              ),
        backgroundColor: Colors.white,
        body: Provider.of<ProductsProvider>(context).dataloadednotifier == false
            ? const Center(child: NointerNet())
            : _pages[index],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: GNav(
                    onTabChange: (newIndex) {
                      setState(() {
                        index = newIndex;
                      });
                    },
                    tabActiveBorder: Border.all(color: secColor, width: 0.2),
                    tabBackgroundColor: mainColor,
                    color: mainColor,
                    activeColor: white,
                    gap: 8,
                    padding: const EdgeInsets.all(16),
                    tabs: const [
                      GButton(
                        icon: Iconsax.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Iconsax.category,
                        text: 'Categories',
                      ),
                      GButton(
                        icon: Iconsax.heart,
                        text: 'Wishlist',
                      ),
                      GButton(
                        icon: Iconsax.profile_2user,
                        text: 'Profile',
                      )
                    ]),
              ),
            ),
          ),
        ),
        drawer: const AppDrawer());
  }

  Future setorder() async {
    Provider.of<ProductsProvider>(context, listen: false).dryskinm();
  }

  Future<void> getcart() async {
    Provider.of<ProductsProvider>(context, listen: false).loadwishlistitems();
    Provider.of<ProductsProvider>(context, listen: false).clearcart();
    Provider.of<ProductsProvider>(context, listen: false)
        .loadcartitems()
        .then((value) {
      setState(() {
        showloading = false;
      });
    });
  }
}
