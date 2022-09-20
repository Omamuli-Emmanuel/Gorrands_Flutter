import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/showUserCustomErrands.dart';
import 'package:goerrand_app/pages/showUserFoodErrands.dart';
import 'package:goerrand_app/pages/showUserGroceryErrands.dart';
import 'package:goerrand_app/pages/showUserPackageErrands.dart';

class MyOrders extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return myOrders();
  }
}

class myOrders extends State<MyOrders>{
  static const customColor = const Color(0xff151B54);
  final user = FirebaseAuth.instance.currentUser;
  String fullname = "";
  int OrderCount = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            return FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot){
                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        heightFactor: 1.5,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, bottom: 5),
                                child: Text("Browse orders by category", textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: "Raleway",
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w700
                                  ),),
                              )
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: customColor
                                ),
                                child: TextButton(
                                child: Text("Food Errands", textAlign: TextAlign.left, style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                ),),
                                  onPressed: ()=> Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ShowUserFoodErrands())),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                            ),


                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: customColor
                                ),
                                child:  TextButton(
                                  child: Text("Package Errands", textAlign: TextAlign.left, style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  onPressed: ()=> Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ShowUserPackageErrands())),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: customColor
                                ),
                                child: TextButton(
                                  child: Text("Grocery Errands", textAlign: TextAlign.left, style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  onPressed: ()=> Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ShowUserGroceryErrands())),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                            ),


                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    color: customColor
                                ),
                                child: TextButton(
                                  child: Text("Custom Errands", textAlign: TextAlign.left, style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  onPressed: ()=> Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ShowUserCustomErrands())),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                );
              },
            );
          },
        ),
    );
  }

  _fetch() async {
    final user = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection("Users")
        .doc(user.email).get()
        .then((dataSnapshot){
      fullname = dataSnapshot.data()!["Full Name"];
      OrderCount = dataSnapshot.data()!["orderCount"];
    });

    FirebaseFirestore.instance.collection("Food Orders").get().then((snap){

    });

  }

}