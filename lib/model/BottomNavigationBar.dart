import 'package:chat_app/pages/ChatPage.dart';
import 'package:chat_app/pages/menuePage.dart';
import 'package:chat_app/pages/profilePage.dart';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  change_item(int value) {
    print(value);
    setState(() {
      currentIndex = value;
    });
  }

  List pages = [
    ChatPage(),
    profilePage(),
    MenuPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label: "Chat",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: "menu",
          ),
        ],
        elevation: 20,
        currentIndex: currentIndex,
        onTap: change_item,
        selectedItemColor: Color(0xff2B475E),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
