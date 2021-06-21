import 'package:biltek/screens/homeScreen.dart';
import 'package:biltek/screens/profileScreen.dart';
import 'package:biltek/screens/settingsScreen.dart';
import 'package:biltek/wixChat.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 2;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WixChat(),
    SettingsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          SettingsScreen(),
          WixChat(),
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        itemBackgroudnColor: Color(0xfffa751b),
        backgroundColor: Color(0xfffa751b),
        items: [
          CustomBottomNavigationBarItem(
            icon: Icons.settings,
            title: "AnaSayfa",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.chat_outlined,
            title: "Destek",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.shopping_basket,
            title: "Ürünler",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.people,
            title: "Profilim",
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 600));
        },
      ),
    );
  }
}
