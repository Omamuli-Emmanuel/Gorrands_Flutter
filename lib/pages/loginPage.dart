import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/HomePage.dart';
import 'package:goerrand_app/pages/registerPage.dart';
import 'package:goerrand_app/pages/welcome.dart';
import 'package:goerrand_app/pages/forgotPassword.dart';

class loginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginFormState();
  }
}

class loginFormState extends State<loginPage> {
  //create form key to validtae form
  final _formKey = GlobalKey<FormState>();
  static const customColor = const Color(0xff151B54);

  final _emailController = TextEditingController();
  final _passworController = TextEditingController();

  // add loading property to track form loading
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/logo.png'),
                    padding: EdgeInsets.only(top: 80.0, left: 80.0, right: 80.0),
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   "Hello there!",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontFamily: "Raleway",
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 52.0,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  // Text(
                  //   "Welcome back, we\'ve missed you!",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontFamily: "Raleway",
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15.0,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                    child: TextFormField(
                      controller: _emailController,
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                    child: TextFormField(
                      controller: _passworController,
                      obscureText: true,
                      validator: _formTextValidation,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState != null &&
                            _formKey.currentState!.validate()){
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 8.0,
                        padding: EdgeInsets.all(10.0),
                      ),
                      child: Text("Login",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: customColor)),
                    ),
                    width: 300,
                    height: 45,
                  ),
                  Padding(
                    child: TextButton(
                      onPressed: () => gotoForgotPassword(context),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                  ),
                  Padding(
                    child:    TextButton(
                      onPressed: () => gotoRegisterPage(context),
                      child: Text(
                        "New to Goerrand?  Register here",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    padding: EdgeInsets.all(5.0)
                  )
                ],
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(color: customColor),
      ),
    );
  }

  gotoRegisterPage(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => registerPage()));

  gotoForgotPassword(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => ForgotPassword()));

  String? _formTextValidation(String? text){
    if(text == null || text.trim().isEmpty){
      return "This field is required";
    }
    return null;
  }

  Future login() async {
    final errorSnackBar = SnackBar(
      backgroundColor: Colors.red[800],
      content: const Text("Oops!, we encountered an error logging you in, please check to be sure you have the right e-mail and password..",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 10000),
    );



    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passworController.text.trim(),
    ).then((value) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => Welcome())))
        .catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    });
  }

  //dispose contollers when not in use to enhance memory management
  @override
  void dispose(){
    _emailController.dispose();
    _passworController.dispose();
    super.dispose();
  }
}


