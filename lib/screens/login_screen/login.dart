import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_app/constants.dart';
import 'package:skin_app/screens/app_screens/home.dart';
import 'package:skin_app/screens/login_screen/signup.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _show = false;
  String emailUser = '';
  String userId = 'userId';
  String showlogin = 'showlogin';
  bool spinner = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final length = MediaQuery.of(context).size.height;
    final defaultPadding = length * 0.040;
    ValueNotifier<bool> visibleText = ValueNotifier(true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: (_show == true)
            ? Center(
                child: Column(
                children: const [
                  SizedBox(
                    height: 400,
                  ),
                  CircularProgressIndicator(
                    color: mainColor,
                  ),
                ],
              ))
            : Form(
                child: Column(children: [
                  SizedBox(
                    height: length * 0.23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: defaultPadding,
                      ),
                      const Text(
                        'HELLO AGAIN!',
                        style: TextStyle(
                            fontSize: 28,
                            color: mainColor,
                            fontFamily: 'Gilroy_Bold'),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: defaultPadding,
                        left: defaultPadding,
                        right: defaultPadding),
                    child: Container(
                        padding: EdgeInsets.only(left: length * 0.02),
                        decoration: BoxDecoration(
                            color: secColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          controller: _email,
                          cursorColor: mainColor,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'Gilroy_Medium'),
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: white, fontFamily: 'Gilroy_Medium'),
                              border: InputBorder.none,
                              icon: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: white,
                                  ))),
                        )),
                  ),
                  ValueListenableBuilder(
                    valueListenable: visibleText,
                    builder: (BuildContext context, bool value, _) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: defaultPadding,
                            left: defaultPadding,
                            right: defaultPadding),
                        child: Container(
                            padding: EdgeInsets.only(left: length * 0.02),
                            decoration: BoxDecoration(
                                color: secColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              controller: _password,
                              obscureText: visibleText.value,
                              obscuringCharacter: '*',
                              cursorColor: mainColor,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy_Medium'),
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  focusColor: Colors.amber,
                                  hintStyle: const TextStyle(
                                      color: white, fontFamily: 'Roboto'),
                                  border: InputBorder.none,
                                  suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        icon: const Icon(
                                          Iconsax.eye,
                                          color: white,
                                        ),
                                        onPressed: () {
                                          PassWordVisible(
                                              visibleText, visibleText.value);
                                        },
                                      )),
                                  icon: const Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: ImageIcon(
                                        AssetImage("assets/privcyLock.png"),
                                        color: white,
                                      ))),
                            )),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                        top: defaultPadding),
                    child: Container(
                        width: 320,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: MaterialButton(
                          splashColor: mainColor,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              _show = false;
                            });
                            login(_email.text, _password.text, context);
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: white,
                              fontFamily: 'Gilroy_Bold',
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Not a user?',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontFamily: 'Gilroy_Medium',
                          )),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Get.to(const SignScreen(),
                              transition: Transition.cupertino,
                              duration: const Duration(seconds: 1));
                        },
                        child: const Text('SignUp Now',
                            style: TextStyle(
                              fontFamily: 'Gilroy_Bold',
                              color: secColor,
                              fontSize: 18,
                            )),
                      ),
                      SizedBox(
                        width: defaultPadding,
                      )
                    ],
                  )
                ]),
              ),
      )),
    );
  }

  Future<void> login(String email, String password, context) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBXy71v_LYOhK161MR-VxqC-Z_tTocusGY';
    try {
      final http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responsData = json.decode(response.body) as Map<String, dynamic>;

      //handling errors

      if (responsData['error'] != null) {
        if (responsData['error']['message'] == 'EMAIL_NOT_FOUND') {
          showdialogue('Incorrect user id',
              'The email address you entered is Incorrect. Please try again.');
        } else if (responsData['error']['message'] == 'INVALID_PASSWORD') {
          showdialogue('Incorrect password',
              'The password you entered is Incorrect. Please try again.');
        }
      } else {
        setShared(email);

        setState(() {
          _show = true;
          navigate();
        });
      }
    } catch (error) {
      rethrow;
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> PassWordVisible(data, currentValue) async {
    if (currentValue == true) {
      data.value = false;
    } else {
      data.value = true;
    }
  }

  void showdialogue(String message, String messagetwo) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text(
                message,
              ),
              content: Text(messagetwo),
              actions: [
                MaterialButton(
                  textColor: mainColor,
                  onPressed: () {
                     setState(() {
                              _show = true;
                            });
                    Navigator.pop(ctx);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  Future<void> setShared(email) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(showlogin, false);
    await sharedPref.setString(userId, email);
  }
}
