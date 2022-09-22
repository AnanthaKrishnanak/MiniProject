import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/providers/product.dart';
import 'package:skin_app/screens/profile_screens/addres.dart';
import 'package:skin_app/screens/splash_screen/intro_splash.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final image = const NetworkImage(
      'https://i.postimg.cc/m2spcWr1/profilepic-removebg-preview.png');

  String showlogin = 'showlogin';
  String user = '';
  @override
  void initState() {
    getuserid();
    super.initState();
  }

  Future<void> getuserid() async {
    final sharedprf = await SharedPreferences.getInstance();
    var val = sharedprf.getString('userId');

    setState(() {
      user = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: height / 12),
                Row(
                  children: [
                    SizedBox(width: width / 20),
                    SizedBox(width: width / 22),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: height / 40,
                        color: Colors.black,
                        fontFamily: 'Gilroy_Bold',
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: height / 30,
                        width: width / 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.more_horiz,
                            size: height / 40,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50),
              ],
            ),
            Column(
              children: [
                SizedBox(height: height / 4),
                Container(
                  height: height / 1.2,
                  width: width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      SizedBox(height: height / 10),
                      Text(
                        'name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height / 35,
                          fontFamily: 'Gilroy_Bold',
                        ),
                      ),
                      SizedBox(height: height / 100),
                      Text(
                        'akak28258@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height / 55,
                          fontFamily: 'Gilroy_Medium',
                        ),
                      ),
                      SizedBox(height: height / 80),
                      const Divider(color: Colors.grey),
                      SizedBox(height: height / 50),
                      GestureDetector(
                        onTap: () {
                          Get.to(const AddressScreen(),
                              transition: Transition.cupertino);
                        },
                        child: settingtype("assets/Profilesa.png",
                            'editaddress', height, width),
                      ),
                      SizedBox(height: height / 50),
                      GestureDetector(
                          onTap: () {},
                          child: settingtype("assets/ShieldDone.png",
                              'security', height, width)),
                      SizedBox(height: height / 50),
                      GestureDetector(
                          onTap: () {},
                          child: settingtype("assets/privcyLock.png",
                              'privacypolicy', height, width)),
                      SizedBox(height: height / 50),
                      GestureDetector(
                          onTap: () {},
                          child: settingtype(
                              "assets/Info.png", 'helpcenter', height, width)),
                      SizedBox(height: height / 50),
                      GestureDetector(
                          onTap: () {
                            bottomsheet(height, width);
                          },
                          child: logout(
                              "assets/Logout.png", 'logout', height, width)),
                      SizedBox(height: height / 30),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: height / 6.5),
                Stack(
                  children: const [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: mainColor,
                        backgroundImage:
                            AssetImage("assets/user-crl-removebg-preview.png"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height / 45),
          ],
        ),
      ),
    );
  }

  Future<void> setShared() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(showlogin, true);
  }

  Future<void> navigate() async {
    Provider.of<ProductsProvider>(context, listen: false).clearall();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  Future bottomsheet(height, width) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: height / 3.7,
          child: Column(
            children: [
              SizedBox(height: height / 50),
              Text(
                'Logout',
                style: TextStyle(
                    color: const Color(0xffF75555),
                    fontSize: height / 35,
                    fontFamily: 'Gilroy_Bold'),
              ),
              SizedBox(height: height / 100),
              const Divider(color: Colors.grey),
              SizedBox(height: height / 60),
              Text(
                'Are you sure your want to log out?',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height / 40,
                    fontFamily: 'Gilroy_Bold'),
              ),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy_Medium'),
                      ),
                    ),
                  ),
                  SizedBox(width: width / 70),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        setShared();

                        navigate();
                      },
                      child: Text(
                        'Yes, Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height / 50,
                            fontFamily: 'Gilroy_Medium'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget settingtype(image, title, height, width) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 20),
          Image.asset(
            image,
            height: height / 27,
            color: Colors.black,
          ),
          SizedBox(width: width / 30),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: height / 50,
              fontFamily: 'Gilroy_Bold',
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: height / 40,
            color: Colors.black,
          ),
          SizedBox(width: width / 20)
        ],
      ),
    );
  }

  Widget logout(image, title, height, width) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 20),
          Image.asset(image, height: height / 27),
          SizedBox(width: width / 30),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xffF75555),
              fontSize: height / 50,
              fontFamily: 'Gilroy_Bold',
            ),
          ),
        ],
      ),
    );
  }
}
