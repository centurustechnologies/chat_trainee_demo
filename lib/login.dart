import 'dart:async';
import 'dart:developer';

import 'package:chatapp/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'tabbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showloader = false;
  bool showHidePassword = true;

  var storage = FlutterSecureStorage();

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/chatw2.png',
                          ),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(60, 60),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome ☺",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login to continue !",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            validator: validateEmail,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              hintText: 'Enter Email...',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            validator: (PassCurrentValue) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              var passNonNullValue = PassCurrentValue ?? "";
                              if (passNonNullValue.isEmpty) {
                                return ("Password is required");
                              } else if (passNonNullValue.length < 6) {
                                return ("Password Must be more than 5 characters");
                              } else if (!regex.hasMatch(passNonNullValue)) {
                                return ("Password should contain upper,lower,digit and Special character ");
                              }
                              return null;
                            },
                            obscureText: showHidePassword,
                            obscuringCharacter: '*',
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Enter Password...',
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.teal,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    showHidePassword = !showHidePassword;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Forget Password',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(20),
                    minWidth: 200,
                    onPressed: () {
                      // log('hgfhg ${nameController.text} ${emailController.text} ${passwordController.text}');
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        log('field empty');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'please fill all details to continue',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          showloader = true;
                        });
                        log('field not empty');

                        FirebaseFirestore.instance
                            .collection('chats')
                            .where('email', isEqualTo: emailController.text)
                            .where('password',
                                isEqualTo: passwordController.text)
                            .get()
                            .then((value) {
                          if (value.docs.isNotEmpty) {
                            log('login Successful');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Center(
                                  child: Text(
                                    'Login Successful',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                            storeLoginData(emailController.text);
                            Timer(Duration(seconds: 2), () {
                              setState(() {
                                showloader = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(
                                    myEmail: emailController.text,
                                  ),
                                ),
                              );
                            });
                          } else {
                            log('please enter details');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'please fill all details to continue',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              showloader
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: CircularProgressIndicator()))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void storeLoginData(email) async {
    await storage.write(key: 'email', value: email);
  }
}
