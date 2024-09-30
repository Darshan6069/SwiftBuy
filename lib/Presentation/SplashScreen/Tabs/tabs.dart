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
  int _currentIndex = 0;

  Widget _returnBody() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CategoriesScreen(
          iD: 'electronics',
        );
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const Text('data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _returnBody(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        items: const [
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
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
