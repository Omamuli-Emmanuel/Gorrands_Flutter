import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OthersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return othersForm();
  }
}

class othersForm extends State<OthersPage> {
  final _formKey = GlobalKey<FormState>();
  static const customColor = const Color(0xff151B54);
  final user = FirebaseAuth.instance.currentUser!;

  final paymentMethod = "Payment to be made on delivery";

  String fullName = "";
  String Phone = "";
  String userId = "";

  final pickUpAddress = TextEditingController();
  final order = TextEditingController();
  final dropOffAddress = TextEditingController();
  final recieverPhone = TextEditingController();

  int customErrand = 0;

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
                        child: Icon(Icons.shuffle, size: 45.0, color: Colors.green[800] ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 8.0),
                        child: Text(
                          "Send custom errand",
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
                SizedBox(height: 25,
                  width: double.infinity,
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot){
                            return Padding(padding: EdgeInsets.only(left: 8.0, bottom: 8.0), child: Text("Errand fee plus delivery fee : ₦" + customErrand.toString(),
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.w500
                              ),));
                          },
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            validator: checkForm,
                            controller: order,
                            maxLines: 3,
                            decoration: InputDecoration(
                              label: Text('Describe your errand'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            controller: pickUpAddress,
                            validator: checkForm,
                            decoration: InputDecoration(
                              label: Text('Pickup Address'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            validator: checkForm,
                            controller: dropOffAddress,
                            decoration: InputDecoration(
                              label: Text('Drop-off address'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            validator: checkForm,
                            controller: recieverPhone,
                            decoration: InputDecoration(
                              label: Text('Reciever\'s Phone number'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(style: BorderStyle.none)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              label: Text('Payments are to be made on delivery'),
                              hintText: user.phoneNumber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(style: BorderStyle.none)),
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
                                  sendErrand();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: customColor,
                                  elevation: 8.0,
                                  padding: EdgeInsets.all(15.0)),
                              child: Text("Send Errand",
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }


  String? checkForm(String? text){
    if(text == null || text.trim().isEmpty){
      return "This field is required";
    }
  }

  _fetch() async  {
    int OrderCount = 0;
    
    await FirebaseFirestore.instance.collection("Users")
    .doc(user.email).get()
    .then((value) => {
        OrderCount = value.data()!["orderCount"]
    });

  if(OrderCount < 10){
     await FirebaseFirestore.instance.collection("Price List")
        .doc('salamikaypetown@gmail.com').get()
        .then((dataSnapshot){
     double grocery = dataSnapshot.data()!["Custom Errands"] * 0.20;
     customErrand = dataSnapshot.data()!["Custom Errands"] - grocery.toInt();
    });
  }else{
     await FirebaseFirestore.instance.collection("Price List")
        .doc('salamikaypetown@gmail.com').get()
        .then((dataSnapshot){
      customErrand = dataSnapshot.data()!["Custom Errands"];
    });
  }

    //automatically refreshes page
    setState(() {});
  }


  Future sendErrand() async {

    final user = await FirebaseAuth.instance.currentUser!;
    if(user != null){
      await FirebaseFirestore.instance.collection("Users")
          .doc(user.email).get()
          .then((dataSnapshot){
        fullName = dataSnapshot.data()!["Full Name"] ?? '';
        Phone = dataSnapshot.data()!["Phone"] ?? '';
        userId = dataSnapshot.data()!["userId"] ?? '';
      });
    }else{
      print("No user found");
    }

    final successSnackBar = SnackBar(
      backgroundColor: Colors.green[800],
      content: const Text("Errand sent successfully. You will be contacted shortly.",
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
      content: const Text("We encountered an error while sending your errand, please try again..",
        style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(milliseconds: 10000),
    );

    var newPackage = {
      'Client Name' : fullName,
      'Client Phone' : Phone,
      'Client Id' : userId,
      'Order': order.text,
      'PickUp Address': pickUpAddress.text,
      'Delivery Address': dropOffAddress.text,
      'Reciever Phone': recieverPhone.text,
      'Payment Method' : paymentMethod,
      'Order type' : "Custom Errand",
      'status': "Pending"
    };

    await FirebaseFirestore.instance.collection("Custom Orders")
        .add(newPackage).then((result) {
    FirebaseFirestore.instance.collection("Users").doc(user.email)
      .get().then((value){

      int prevOrderCount = value.data()!["orderCount"];
      
      FirebaseFirestore.instance.collection("Users")
      .doc(user.email).update({"orderCount" : prevOrderCount + 1})
      .then((value){
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
      });
        
      });
    }).catchError((error){
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    });
  }

}