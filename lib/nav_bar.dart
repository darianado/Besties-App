import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  int currentIndex;

  NavBar({required this.currentIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _items = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        activeIcon: Icon(Icons.account_circle),
        label: 'profile',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline_rounded),
        activeIcon: Icon(Icons.chat_bubble_rounded),
        label: 'chats',
      ),
    ];

    void _fillIcon(int index) {
      setState(() {
        widget.currentIndex = index;
      });

      //redirect call
    }

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: _fillIcon,
      items: _items,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
    );
  }
}
