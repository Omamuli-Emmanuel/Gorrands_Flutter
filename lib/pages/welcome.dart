import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goerrand_app/pages/softCatPage.dart';
import 'package:goerrand_app/pages/loginPage.dart';
import 'package:goerrand_app/pages/onBoarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin.dart';

class Welcome extends StatefulWidget{
  @override
  _WelcomeChoose createState() => _WelcomeChoose();
}

class _WelcomeChoose extends State<Welcome> with SingleTickerProviderStateMixin{
  //define user account type
  String accountType = "";
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if(snapshot.hasData){

                 return FutureBuilder(
                     future: _fetch(),
                     builder: (context, snapshot){
                        if(accountType == "Admin"){
                          return AdminPage();
                        }
                        if(accountType == "Member"){
                          return SoftPage();
                        }
                        return Center(
                          child: Text("Loading your data, please wait...."),
                        );
                     },
                 );
              }else{
                return onBoarding();
              }
            },
        ),
      ),
    );
  }
  _fetch() async {
    final user = await FirebaseAuth.instance.currentUser!;
    if(user != null){
     await FirebaseFirestore.instance.collection("Users")
          .doc(user.email).get()
          .then((dataSnapshot){
            accountType = dataSnapshot.data()!["account"] ?? '';
          });
    }
  }
}

