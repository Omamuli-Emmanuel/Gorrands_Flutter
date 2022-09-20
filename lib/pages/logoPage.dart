import 'package:flutter/material.dart';

import 'loginPage.dart';

class logoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const customColor = const Color(0xff151B54);
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  "LET'S HELP TAKE THE STRESS OFF YOUR SHOULDERS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(top: 80.0, left: 80.0, right: 80.0),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () => gotoLogin(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 8.0,
                ),
                child: Text("Get Started",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: customColor)),
              ),
              margin: EdgeInsets.only(bottom: 60.0),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        image : DecorationImage(
          image: AssetImage("assets/getStarted.jpg"),
          fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken)
        ),
      ),
    ));
  }

  gotoLogin(context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => loginPage()));
}
