import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PriceControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return priceControl();
  }
}

class priceControl extends State<PriceControl> {
  final _formKey = GlobalKey<FormState>();
  static const customColor = const Color(0xff151B54);
  final user = FirebaseAuth.instance.currentUser!;
  final dbData =
  FirebaseFirestore.instance.collection("Price List").doc(FirebaseAuth.instance.currentUser?.email).get();

  int packageErrand = 0;
  int foodErrand = 0;
  int groceryErrand = 0;
  int customErrand = 0;

  var payments = ['Payment on delivery'];
  int _selectedIndex = 0;

  // create form controllers
  final packageprice = TextEditingController();
  final foodprice = TextEditingController();
  final groceryprice = TextEditingController();
  final customprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title : Text("Goerrands"),
          backgroundColor: customColor,
        ),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: Icon(Icons.price_change, size: 45.0,
                            color: Colors.green[800]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 8.0),
                        child: Text(
                          "Add and update price list",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Raleway",
                              fontSize: 21),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  width: double.infinity,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            controller: packageprice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Package Errands'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            controller: foodprice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Food Errands'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            controller: groceryprice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Grocery Errands'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            controller: customprice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Custom Errands'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      style: BorderStyle.none)),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  sendPackage();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: customColor,
                                  elevation: 8.0,
                                  padding: EdgeInsets.all(15.0)),
                              child: Text("Add / Update price list",
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        StreamBuilder<User?>(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){

                              return FutureBuilder(
                                future: _fetch(),
                                builder: (context, snapshot){
                                  return Padding(padding: EdgeInsets.all(10.0),
                                      child: Expanded(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text("Current price list",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Raleway"
                                                ),),
                                              SizedBox(
                                                height: 10.0,
                                                width: double.infinity,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Text("Package Errand Price :", style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily: "Raleway"
                                                    ),),
                                                    Text("₦" + packageErrand.toString(), style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily: "Raleway"
                                                    ),)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                                width: double.infinity,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Food Errand Price :", style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),),
                                                  Text("₦" + foodErrand.toString(), style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                                width: double.infinity,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Grocery Errand Price :", style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),),
                                                  Text("₦" + groceryErrand.toString(), style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                                width: double.infinity,
                                              ),
                                              Row(
                                                children: [
                                                  Text("Custom Errand Price :", style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),),
                                                  Text("₦" + customErrand.toString(), style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Raleway"
                                                  ),)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                },
                              );
                            }else{
                              return Container();
                            }
                          },
                        ),


                      ],
                    )
                )
              ],
            )),
      ),
    );
  }

  _fetch() async  {
    await FirebaseFirestore.instance.collection("Price List")
        .doc(user.email).get()
        .then((dataSnapshot){
      packageErrand = dataSnapshot.data()!["Package Errands"];
      foodErrand = dataSnapshot.data()!["Food Errands"];
      groceryErrand = dataSnapshot.data()!["Grocery Errands"];
      customErrand = dataSnapshot.data()!["Custom Errands"];
    });

    //automatically refreshes page
    setState(() {});
  }

  Future sendPackage() async {
    final user = await FirebaseAuth.instance.currentUser!;

    final successSnackBar = SnackBar(
      backgroundColor: Colors.green[800],
      content: const Text("Price list updated successfully.",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 10000),
    );

    final errorSnackBar = SnackBar(
      backgroundColor: Colors.red[800],
      content: const Text("We encountered an error while tring to update price list, please try again..",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 10000),
    );

    var newPriceList = {
      'Package Errands': int.parse(packageprice.text),
      'Food Errands': int.parse(foodprice.text),
      'Grocery Errands': int.parse(groceryprice.text),
      'Custom Errands': int.parse(customprice.text),
    };

    await FirebaseFirestore.instance.collection("Price List").doc(user.email).set(newPriceList).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    });
  }


}

