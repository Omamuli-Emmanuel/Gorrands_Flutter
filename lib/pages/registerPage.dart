import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/loginPage.dart';
import 'dart:developer';


class registerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerPageFormState();
  }
}

class registerPageFormState extends State<registerPage> {
  //create form key to validtae form
  final _formKey = GlobalKey<FormState>();
  final firebaseUser = FirebaseAuth.instance;
  // add loading property to track form loading
  var loading = false;

  // initialize text editing controllers to get data from form
  final _nameController = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  //declear custom color
  static const customColor = const Color(0xff151B54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  "Signup",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(top: 80.0),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(
                        color: customColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(style: BorderStyle.none)),
                    ),
                    keyboardType: TextInputType.text,
                    validator: _requiredValidator,
                  )),
              const SizedBox(height: 3.0),
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(
                        color: customColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(style: BorderStyle.none)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: _requiredValidator,
                  )),
              const SizedBox(height: 3.0),
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _phone,
                    decoration: InputDecoration(
                      hintText: "Phone",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.phone),
                      hintStyle: TextStyle(
                        color: customColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(style: BorderStyle.none)),
                    ),
                    keyboardType: TextInputType.number,
                    validator: _requiredNumbervalidator,
                  )),
              const SizedBox(height: 3.0),
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.password),
                      hintStyle: TextStyle(
                        color: customColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(style: BorderStyle.none)),
                    ),
                    obscureText: true,
                    validator: _requiredValidator,
                  )),
              const SizedBox(height: 3.0),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _confirmPassword,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.password),
                      hintStyle: TextStyle(
                        color: customColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(style: BorderStyle.none)),
                    ),
                    obscureText: true,
                    validator: _confirmPasswordValidator,
                  )),
              const SizedBox(height: 3.0),

              if(loading)...[
                  Center(child: CircularProgressIndicator())
              ],

              if(!loading)...[
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 8.0,
                        padding: EdgeInsets.all(15.0)),
                    child: Text("Create account",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: customColor)),
                  ),
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 8.0, bottom: 10.0),
                )
              ],
              TextButton(
                onPressed: () => gotoLoginPage(context),
                child: Text(
                  "Already a member?  Login here",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(color: customColor),
      ),
    );
  }

  gotoLoginPage(context) =>
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => loginPage()));

  //declear required validator
  String? _requiredValidator(String? text) {
    if (text == null || text
        .trim()
        .isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  //declear required validator for phone number
  String? _requiredNumbervalidator(String? number) {
    if (number == null) {
      return 'This field is required';
    }
    if (number.length < 11) {
      return 'Please provide a valid number up to 11 digits';
    }
    return null;
  }

  //validator to confirm password
  String? _confirmPasswordValidator(String? pass) {
    if (pass == null || pass
        .trim()
        .isEmpty) {
      return 'This field is required';
    }
    if (_password.text != _confirmPassword.text) {
      return "Passwords do not match";
    }
  }

  Future _signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await firebaseUser.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      //put user details into firebase firestore collection


      var userId = firebaseUser.currentUser!;
      var newUser = {
          'Full Name': _nameController.text,
          'Email': _email.text,
          'Phone': _phone.text,
          'Password': _password.text,
          'account' : "Member",
          'orderCount' : 0,
          'userId' : userId.uid
        };

      await FirebaseFirestore.instance.
      collection("Users").doc(userId.email.toString()).set(newUser)
      .then((value) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => loginPage())))
      .catchError((e) {
        print(e);
      });

      // await showDialog(context: context, builder: (builder) =>
      //     AlertDialog(
      //       title: Text("Awesome!!"),
      //       content: Text("Your account was created successfully."),
      //       actions: [TextButton(onPressed:(){
      //       Navigator.of(context).pop();
      //       }, child:
      //       Text("Ok"))],
      //     ));
      //   Navigator.of(context).pop();

    }on FirebaseAuthException catch(e){
      log('data: $e');
      _handleSignUpError(e);
        setState(() {
          loading = true;
        });
    }
  }
  void _handleSignUpError(FirebaseAuthException e){
    String message;
    switch(e.code){
      case 'email already in use':
        message = 'This email is already in use';
        break;
      case 'invalid-email':
        message = 'The email entered is invalid';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed';
        break;
      case 'weak-password':
        message = 'The password you entered is too week';
        break;
      default:
        message = 'An unknown error occured';
        break;
    }
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Awesome!!"),
      content: Text(message),
      actions: [TextButton(onPressed:(){
        Navigator.of(context).pop();
      }, child:
      Text("Ok"))],
    ));
    Navigator.of(context).pop();
  }
}


