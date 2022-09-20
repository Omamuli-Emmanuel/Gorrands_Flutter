import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'loginPage.dart';

class CreateNewPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return newPassword();
  }
}

class newPassword extends State<CreateNewPassword> {
  //create form key to validtae form
  final _formKey = GlobalKey<FormState>();
  static const customColor = const Color(0xff151B54);
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();

  final successSnackBar = SnackBar(
    backgroundColor: Colors.green[800],
    content: const Text(
      "Password updated successfully",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Ok',
      onPressed: () {},
    ),
    duration: Duration(milliseconds: 10000),
  );

  final errorSnackBar = SnackBar(
    backgroundColor: Colors.red[800],
    content: const Text(
      "Oops! We couldn't update your password, please check that your email is correct ",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Raleway",
          fontWeight: FontWeight.w700),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Ok',
      onPressed: () {},
    ),
    duration: Duration(milliseconds: 10000),
  );

  // final dbData = FirebaseFirestore.instance.collection("Users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      child: Text(
                        "Create new password",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 25.0,
                          fontFamily: 'Raleway',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      padding:
                          EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0)),
                  Padding(
                      child: (TextFormField(
                        controller: emailController,
                        validator: _formTextValidation,
                          keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.email),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(style: BorderStyle.none)),
                        ),
                        style: TextStyle(
                          color: customColor,
                        ),
                      )),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0, top: 5.0)),
                  Padding(
                      child: (TextFormField(
                        controller: passwordController,
                        validator: _formTextValidation,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'New password',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.password),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(style: BorderStyle.none)),
                        ),
                        style: TextStyle(
                          color: customColor,
                        ),
                        obscureText: true,
                      )),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0, top: 5.0)),
                  Padding(
                      child: (TextFormField(
                        controller: confirmPasswordController,
                        validator: _formTextValidation,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.password),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Raleway',
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(style: BorderStyle.none)),
                        ),
                        style: TextStyle(
                          color: customColor,
                        ),
                        obscureText: true,
                      )),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0, top: 5.0)),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null &&
                            _formKey.currentState!.validate()) {
                          resetPassword(emailController.text.toString());
                        }
                      },
                      child: Text(
                        "Change password",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: customColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 8.0,
                        padding: EdgeInsets.all(10.0),
                      ),
                    ),
                    width: 300,
                  ),
                  TextButton(
                      onPressed: () => gotoLoginPage(context),
                      child: Text(
                        "Already a member?  Login here",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(color: customColor),
    ));
  }

  String? _formTextValidation(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  gotoLoginPage(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => loginPage()));
}
