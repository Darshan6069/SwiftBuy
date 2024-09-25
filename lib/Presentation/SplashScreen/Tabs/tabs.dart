import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/cart_screen.dart';
import '../Screens/categories_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart_badge_plus),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => HomeScreen());
          case 1:
            return CupertinoTabView(builder: (context) => CategoriesScreen(iD: 'electronics',));
          case 2:
            return CupertinoTabView(builder: (context) => CartScreen());
          case 3:
            return CupertinoTabView(builder: (context) => ProfileScreen());
          default:
            return Text('data');
        }
      },
    );
  }
}
