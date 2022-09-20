
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goerrand_app/pages/HomePage.dart';
import 'package:goerrand_app/pages/contactPage.dart';

import 'myOrders.dart';


class SoftPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return softPage();
  }
}

class softPage extends State<SoftPage> {
  static const customColor = const Color(0xff151B54);

  final screens = [
    HomePage(),
    MyOrders(),
    Contact()
  ];
  var payments = ['Payment on delivery'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Goerrands"),
        backgroundColor: customColor,
      ),
      body:  screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Menu', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'My Orders', backgroundColor: customColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: 'Contact us', backgroundColor: customColor),
        ],
      ),
    );
  }
}
