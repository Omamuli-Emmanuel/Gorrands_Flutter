import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Custom extends StatefulWidget{
  @override
  HelloCustom createState() => HelloCustom();
}

class HelloCustom extends State<Custom> {
  static const customColor = const Color(0xff151B54);
  final dbData = FirebaseFirestore.instance.collection("Custom Orders").snapshots();

  String ErrandType = "";


  final successSnackBar = SnackBar(
    backgroundColor: Colors.green[800],
    content: const Text("Errand status updated successfully.",
      style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Ok',
      onPressed: (){},
    ),
    duration: Duration(milliseconds: 2000),
  );

  final successSnackBarDeleteOrder = SnackBar(
    backgroundColor: Colors.green[800],
    content: const Text("Errand canceled successfully.",
      style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Ok',
      onPressed: (){},
    ),
    duration: Duration(milliseconds: 2000),
  );

  final errorSnackBar = SnackBar(
    backgroundColor: Colors.red[800],
    content: const Text("We encountered an error while trying to update errand status, please try again..",
      style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontWeight: FontWeight.w700),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Ok',
      onPressed: (){},
    ),
    duration: Duration(milliseconds: 2000),
  );



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("GoErrands Admin"),
          backgroundColor: customColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: dbData,
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.data?.docs == null)
              return Center(
                  child: Text("Fetching data.... ")
              );

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            return Center(
              child:  ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (ctx, index) {
                    if(snapshot.data?.docs[index]['status'] != "Completed"){
                      return Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(snapshot.data?.docs[index]['Order type']),
                          subtitle: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Client Name'])
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Client Phone'])
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Errand", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Order'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("PickUp Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['PickUp Address'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("DropOff Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Delivery Address'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Reciever's contact", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Reciever Phone'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Errand Status", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['status'], style: TextStyle(
                                      fontWeight: FontWeight.w700, fontFamily: "Raleway", color: Colors.red
                                  ),)
                              ),
                            ],
                          ),
                          leading: Icon(Icons.notification_important),
                          trailing: Icon(Icons.label_important, color: Colors.red,),
                          onTap: (){
                            var item = FirebaseFirestore.instance.collection("Custom Orders").doc(snapshot.data?.docs[index].id.toString());
                            item.update({"status" : "Processing..."}).then((result) {
                              ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                            }).catchError((error){
                              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                            });
                          },
                        ),
                      );
                    }else{
                      return Card(
                        elevation: 1,
                        child: ListTile(
                          title: Text(snapshot.data?.docs[index]['Order type']),
                          subtitle: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Client Name'])
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Client Phone'])
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Errand", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Order'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("PickUp Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['PickUp Address'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("DropOff Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Delivery Address'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Reciever's contact", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['Reciever Phone'])
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text("Errand Status", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(snapshot.data?.docs[index]['status'], style: TextStyle(
                                      fontWeight: FontWeight.w700, fontFamily: "Raleway", color: Colors.green
                                  ),)
                              ),
                              SizedBox(
                                      width: double.infinity,
                                      child: Text('This errand is marked completed. to delete it, simply tap this box', style: TextStyle(
                                          fontWeight: FontWeight.w300, fontFamily: "Raleway", color: Colors.red[800]
                                      ),)
                                  ),
                            ],
                          ),
                          leading: Icon(Icons.check_box_rounded, color: Colors.green,),
                          trailing: Icon(Icons.label_important, color: Colors.green,),
                          onTap: (){
                            var item = FirebaseFirestore.instance.collection("Custom Orders").doc(snapshot.data?.docs[index].id.toString());
                                                item.delete().then((result) {
                                                  ScaffoldMessenger.of(context).showSnackBar(successSnackBarDeleteOrder);
                                                }).catchError((error){
                                                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                                });
                          },
                        ),
                      );
                    }

                  }
              ),
            );
          },
        ),
      ),
    );
  }
}
