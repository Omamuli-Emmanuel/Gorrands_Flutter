import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Support Channels",
            style: TextStyle(
                fontFamily: "RaleWay",
                fontSize: 35.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_outlined),
              Text("23480xx-xxx-xxx",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              )
            ],
          ),
          width: double.infinity,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_outlined),
              Text("23480xx-xxx-xxx",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              )
            ],
          ),
          width: double.infinity,
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email_outlined),
                Text("support@goerrands.com",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w200
                  ),
                )
              ],
            ),
          ),
          width: double.infinity,
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Follow us",
            style: TextStyle(
                fontFamily: "RaleWay",
                fontSize: 35.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook),
              Text("23480xx-xxx-xxx",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              )
            ],
          ),
          width: double.infinity,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Instagram : ",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              ),
              Text("23480xx-xxx-xxx",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              )
            ],
          ),
          width: double.infinity,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Twitter : ",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              ),
              Text("23480xx-xxx-xxx",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w200
                ),
              )
            ],
          ),
          width: double.infinity,
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
          child: Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  elevation: 8.0,
                  padding: EdgeInsets.all(15.0)),
              child: Text("Logout",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
            ),
          ),
        )
      ],
    );
  }
}
