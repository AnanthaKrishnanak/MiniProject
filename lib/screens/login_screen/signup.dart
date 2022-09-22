import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:skin_app/constants.dart';
import 'package:http/http.dart' as http;

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

final _formKey = GlobalKey<FormState>();

final passwordControllerOne = TextEditingController();
final passwordControllerTwo = TextEditingController();
final nameController = TextEditingController();
final emailController = TextEditingController();

ValueNotifier<String> icorrectText = ValueNotifier('');
ValueNotifier<bool> visibleText = ValueNotifier(true);

class _SignScreenState extends State<SignScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final length = MediaQuery.of(context).size.height;

    final defaultPadding = length * 0.040;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: length * 0.16,
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
                        controller: nameController,
                        cursorColor: mainColor,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: white, fontFamily: 'Gilroy_Medium'),
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: white,
                          ),
                          hintText: 'Name',
                          hintStyle:
                              TextStyle(color: white, fontFamily: 'Roboto'),
                          border: InputBorder.none,
                        ))),
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
                        controller: emailController,
                        cursorColor: mainColor,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: white, fontFamily: 'Gilroy_Medium'),
                        decoration: const InputDecoration(
                          icon: Icon(
                            EvaIcons.emailOutline,
                            color: white,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: white, fontFamily: 'Gilroy_Medium'),
                          border: InputBorder.none,
                        ))),
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
                          controller: passwordControllerOne,
                          obscureText: visibleText.value,
                          cursorColor: mainColor,
                          style: const TextStyle(
                              color: white, fontFamily: 'Gilroy_Medium'),
                          decoration: const InputDecoration(
                            icon: ImageIcon(
                              AssetImage("assets/privcyLock.png"),
                              color: white,
                            ),
                            hintText: 'New password',
                            focusColor: Colors.amber,
                            hintStyle: TextStyle(
                                color: white, fontFamily: 'Gilroy_Medium'),
                            border: InputBorder.none,
                          ),
                        )),
                  );
                },
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
                          controller: passwordControllerTwo,
                          obscureText: visibleText.value,
                          cursorColor: mainColor,
                          style: const TextStyle(color: white),
                          decoration: InputDecoration(
                            icon: const ImageIcon(
                              AssetImage("assets/privcyLock.png"),
                              color: white,
                            ),
                            hintText: 'Confirm password',
                            focusColor: Colors.amber,
                            hintStyle: const TextStyle(
                                color: white, fontFamily: 'Gilroy_Medium'),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: const Icon(
                                    (Iconsax.eye),
                                    color: white,
                                  ),
                                  onPressed: () {
                                    PassWordVisible(
                                        visibleText, visibleText.value);
                                  },
                                )),
                          ),
                        )),
                  );
                },
              ),
              ValueListenableBuilder(
                  valueListenable: icorrectText,
                  builder: (BuildContext context, val, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: length * 0.033,
                          child: Text(
                            icorrectText.value,
                            style: const TextStyle(
                                color: red, fontFamily: 'Gilroy_Medium'),
                          ),
                        ),
                        SizedBox(
                          width: defaultPadding + 5,
                        )
                      ],
                    );
                  }),
              Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding,
                  right: defaultPadding,
                ),
                child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      splashColor: mainColor,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        CheckPassword(passwordControllerOne.text,
                            passwordControllerTwo.text, icorrectText, context);
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontFamily: 'Gilroy_Bold'),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Already a user?',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: 'Gilroy_Medium')),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Login Instead',
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
            ],
          ),
        )),
      ),
    );
  }

  void showdialogue(String message, String messagetwo) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text(
                message,
                style: const TextStyle(
                    color: mainColor, fontFamily: 'Gilroy_Bold', fontSize: 25),
              ),
              content: Text(
                messagetwo,
                style: const TextStyle(
                    color: mainColor,
                    fontFamily: 'Gilroy_Medium',
                    fontSize: 20),
              ),
              actions: [
                MaterialButton(
                  textColor: mainColor,
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: 'Gilroy_Bold',
                        fontSize: 25),
                  ),
                ),
              ],
            ));
  }

  // ignore: non_constant_identifier_names
  Future<void> PassWordVisible(data, currentValue) async {
    if (currentValue == true) {
      data.value = false;
    } else {
      data.value = true;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBXy71v_LYOhK161MR-VxqC-Z_tTocusGY';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final response = json.decode(res.body);
      if (response['error'] != null) {
        if (response['error']['message'] == 'EMAIL_EXISTS') {
          showdialogue('Email exists',
              'The email you entered is already registered. Please login.');
        } else if (response['error']['message'] == 'INVALID_EMAIL') {
          showdialogue('Invalid email',
              'The email you entered is invalid. Please try again.');
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        setuserdb(email);
        postUserData(email, name);
        _formKey.currentState?.reset();
      }
    } catch (error) {
      rethrow;
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> CheckPassword(
      newPassword, confirmPassword, text, context) async {
    if (newPassword != confirmPassword ||
        newPassword == null ||
        confirmPassword == null) {
      text.value = 'Password not matching!';
      _formKey.currentState?.reset();
    } else if (newPassword.toString().length < 8) {
      text.value = 'Password must be atleast 8 characters long!';
      _formKey.currentState?.reset();
    } else if (newPassword == confirmPassword &&
        newPassword != null &&
        newPassword.toString().length >= 8) {
      signup(emailController.text, passwordControllerOne.text,
          nameController.text);
    }
  }

  Future<void> setuserdb(id) async {
    const url =
        'https://skin-app-db-7eb42-default-rtdb.firebaseio.com/USERDATA.json';

    await http.post(Uri.parse(url), body: json.encode({'user': id}));
  }

  Future<void> postUserData(email, name) async {
    const url = 'https://user-data-f47b3-default-rtdb.firebaseio.com/.json';

    try {
      await http.post(Uri.parse(url),
          body: json.encode({'userid': email, 'user': name}));
    } catch (e) {
      rethrow;
    }
  }
}
