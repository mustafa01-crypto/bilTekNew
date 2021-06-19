import 'package:biltek/screens/homeScreen.dart';
import 'package:biltek/screens/profileScreen.dart';
import 'package:biltek/screens/settingsScreen.dart';
import 'package:biltek/wixChat.dart';
import 'package:flutter/material.dart';
import 'constants/constants.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 2;

  static List<Widget> _widgetOptions = <Widget>[
    Center(child: HomeScreen()),
    Center(child: WixChat()),
    Center(child: SettingsScreen()),
    Center(child: ProfileScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor: turuncu,
        selectedIconTheme: IconThemeData(
          size: 45,
        ),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: turuncu,
        onTap: _onItemTapped,
      ),
    );
  }
}
