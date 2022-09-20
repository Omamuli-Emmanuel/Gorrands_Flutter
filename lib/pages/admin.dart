import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/adminPriceControl.dart';
import 'package:goerrand_app/pages/custom.dart';
import 'package:goerrand_app/pages/food.dart';
import 'package:goerrand_app/pages/grocery.dart';
import 'package:goerrand_app/pages/logout.dart';
import 'package:goerrand_app/pages/package.dart';

class AdminPage extends StatefulWidget {
  @override
  HelloAdmin createState() => HelloAdmin();
}

class HelloAdmin extends State<AdminPage> {
  static const customColor = const Color(0xff151B54);
  final user = FirebaseAuth.instance.currentUser!;
  final screens = [
    Package(),
    Food(),
    Grocery(),
    Custom(),
    PriceControl(),
    Logout()
  ];
  var payments = ['Payment on delivery'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              label: 'Packages',
              backgroundColor: customColor
          ),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Food', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store), label: 'Grocieries', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.shuffle), label: 'Others', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.price_change), label: 'Price list', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout), label: 'LogOut', backgroundColor: customColor)
        ],
      ),
    );
  }
}


