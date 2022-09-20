// @dart=2.9
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/onBoarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:goerrand_app/pages/welcome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static const customColor = const Color(0xff151B54);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Go Errands',
        theme: ThemeData(
          primaryColor: customColor,
          hintColor: customColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: customColor,
          ),
        ),
        home: Welcome());
  }
}
