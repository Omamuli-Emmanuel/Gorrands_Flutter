import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/packagePage.dart';
import 'package:goerrand_app/pages/showUserFoodErrands.dart';

class ShowUserPackageErrands extends StatefulWidget{
  @override
  ShowUserPackage createState() => ShowUserPackage();
}

class ShowUserPackage extends State<ShowUserPackageErrands> {
  static const customColor = const Color(0xff151B54);
  final dbData =
  FirebaseFirestore.instance.collection("Package Orders").snapshots();

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

  final successSnackBarDelete = SnackBar(
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

  final successSnackBarDeleteOrder = SnackBar(
    backgroundColor: Colors.green[800],
    content: const Text("Errand deleted successfully.",
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

  String ErrandType = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text("GoErrands"),
              backgroundColor: customColor,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back))
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

              // if(snapshot.data?.docs.length == 0){
              //   return Center(
              //     heightFactor: 2.0,
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 150.0,
              //         ),
              //         Text("You have no records for this category"),
              //         ElevatedButton(onPressed: ()=> Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => PackagePage())),
              //             style: ElevatedButton.styleFrom(
              //               primary: customColor
              //             ),
              //             child: Text("Send a new package errand"))
              //       ],
              //     ),
              //   );
              // }

              return Center(
                child:  ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (ctx, index) {

                      if(snapshot.data?.docs[index]['Client Id'] == FirebaseAuth.instance.currentUser?.uid.toString()){

                        if(snapshot.data?.docs[index]['status'] != "Completed"){
                          return Card(
                            elevation: 1,
                            color: customColor,
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['Order type'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Client Name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Client Phone'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(height: 10.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("Errand", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Package Description'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("PickUp Address", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Pickup Address'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("DropOff Address", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Drop-off Address'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("Reciever's contact", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Reciever'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("Errand Status", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['status'], style: TextStyle(
                                          fontWeight: FontWeight.w700, fontFamily: "Raleway", color: Colors.red, fontSize: 18.0
                                      ),)
                                  ),
                                  
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary : Colors.green[800]
                                                ),
                                                onPressed: (){
                                                  var item = FirebaseFirestore.instance.collection("Package Orders").doc(snapshot.data?.docs[index].id.toString());
                                                  item.update({"status" : "Completed"}).then((result) {
                                                    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                                                  }).catchError((error){
                                                    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                                  });
                                                },
                                                child: Text("Errand Completed")
                                            ),
                                          )
                                      ),

                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary : Colors.red[800]
                                              ),
                                              onPressed: (){
                                                var item = FirebaseFirestore.instance.collection("Package Orders").doc(snapshot.data?.docs[index].id.toString());
                                                item.delete().then((result) {
                                                  ScaffoldMessenger.of(context).showSnackBar(successSnackBarDelete);
                                                }).catchError((error){
                                                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                                });
                                              },
                                              child: Text("Cancel Errand")
                                          )
                                      )
                                    ],
                                  )
                                ],
                              ),

                            ),
                          );
                        }else{
                          return Card(
                            elevation: 1,
                            child: ListTile(
                              title: Text(snapshot.data!.docs[index]['Order type']),
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
                                      child: Text(snapshot.data?.docs[index]['Package Description'])
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("PickUp Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Pickup Address'])
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("DropOff Address", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Drop-off Address'])
                                  ),
                                  SizedBox(height: 5.0),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text("Reciever's contact", style: TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w200),)
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(snapshot.data?.docs[index]['Reciever'])
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
                                var item = FirebaseFirestore.instance.collection("Package Orders").doc(snapshot.data?.docs[index].id.toString());
                                                item.delete().then((result) {
                                                  ScaffoldMessenger.of(context).showSnackBar(successSnackBarDeleteOrder);
                                                }).catchError((error){
                                                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                                                });
                              },
                            ),
                          );
                        }
                      }else{
                        return Container();
                      }
                    }
                ),
              );
            },
          ),
        ),
        onWillPop: () async => false
    );
  }
}
