import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/createNewPassword.dart';

import 'loginPage.dart';


class ForgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Forgot();
  }
}

class Forgot extends State<ForgotPassword> {
  //create form key to validtae form
  final _formKey = GlobalKey<FormState>();
  static const customColor = const Color(0xff151B54);
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Padding(
                    //   child: Image.asset('assets/logo.png'),
                    //   padding: EdgeInsets.only(top: 80.0, left: 80.0, right: 80.0),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        child: Text(
                          "Let's find your email",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 25.0,
                            fontFamily: 'Raleway',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0)
                    ),
                    Padding(
                        child: (
                            TextFormField(
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
                            )
                        ),
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 5.0)
                    ),
                    SizedBox(
                      child: ElevatedButton(onPressed: () {
                        if(_formKey.currentState != null &&
                            _formKey.currentState!.validate()){
                          resetPassword(_emailController.text.toString());
                        }
                      },
                        child: Text(
                          "Find my account",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: customColor
                          ),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(color: customColor),
        )
    );
  }

  String? _formTextValidation(String? text){
    if(text == null || text.trim().isEmpty){
      return "This field is required";
    }
    return null;
  }

  gotoLoginPage(context) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => loginPage()));

  @override
  Future<void> resetPassword(String email) async {
    final successSnackBar = SnackBar(
      backgroundColor: Colors.green[800],
      content: const Text("We found your account, please check your e-mail to proceed. Be sure to check your spam mail too...",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 20000),
    );
    final errorSnackBar = SnackBar(
      backgroundColor: Colors.red[800],
      content: const Text("We couldnt find your account, please make sure you put in the right email with no spaces at the end..",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 10000),
    );

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email)
    .then((value) => ScaffoldMessenger.of(context).showSnackBar(successSnackBar),
    onError: (e) => ScaffoldMessenger.of(context).showSnackBar(errorSnackBar)
    );
  }


}

