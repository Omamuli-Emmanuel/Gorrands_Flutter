
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goerrand_app/pages/custom.dart';
import 'package:goerrand_app/pages/groceriesPage.dart';
import 'package:goerrand_app/pages/grocery.dart';
import 'package:goerrand_app/pages/others.dart';
import 'package:goerrand_app/pages/packagePage.dart';

import 'foodPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return bottomNav();
  }
}

class bottomNav extends State<HomePage> {
  static const customColor = const Color(0xff151B54);
  final user = FirebaseAuth.instance.currentUser;
  //define user account type
  String fullname = "";
  int OrderCount = 0;
  
  String orderMessage = "";

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          return FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        child: Text(
                                          "Hello "+fullname,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                                      )
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      child: Text(
                                        "How can we help you today?",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: ElevatedButton(
                              onPressed: (){
                                signOut();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                              ),
                              child: Icon(Icons.logout, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 200.0,
                      width: 400,
                      child: ListView(
                        children: [
                          CarouselSlider(items: [

                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/toDoList.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/runErrands.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/intro.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage('assets/smug.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                          ], options: CarouselOptions(
                            height: 180.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          )
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        child: Text(orderMessage, textAlign: TextAlign.center,),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      )
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 5.0, right: 5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: customColor
                                ),
                                onPressed: ()=> Navigator.push(context,
                                MaterialPageRoute(builder: (context) => FoodPage())),
                                child: Padding(
                                  padding: EdgeInsets.all(24.5),
                                  child: Column(
                                    children: [
                                      Icon(Icons.fastfood),
                                      Text("Fast Food / snacks errands", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 5.0, right: 10.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: customColor
                                ),
                                onPressed: ()=> Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Grocieries())),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.shopping_cart),
                                      Text("Supermarket / local market errands", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: customColor
                                ),
                                onPressed: ()=> Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => PackagePage())),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.card_giftcard),
                                      Text("Package pickup & delivery errands", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 10.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: customColor
                                ),
                                onPressed: ()=> Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => OthersPage())),
                                child: Padding(
                                  padding: EdgeInsets.all(22.5),
                                  child: Column(
                                    children: [
                                      Icon(Icons.list),
                                      Text("Custom personal errands ", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 10.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: customColor
                                ),
                                onPressed: ()=> Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => OthersPage())),
                                child: Padding(
                                  padding: EdgeInsets.all(22.5),
                                  child: Column(
                                    children: [
                                      Icon(Icons.business),
                                      Text("Business errands ", textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ],
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
    
    if (OrderCount <= 10){
      orderMessage = "Congratulations!! you are eligible for a 20% discount on your first 10 orders";
    }else{
      orderMessage = "";
    }
  }

  Future<void> signOut() async{
    print("Logging out");
    await FirebaseAuth.instance.signOut();
  }

}
