import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/sign_up1.dart';

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

    // Updates the navbar's icon index and TODO: navigates to the new page
    void _handleIconTap(int index) {
      setState(() {
        widget.currentIndex = index;
      });

      switch (widget.currentIndex) {
        case (Constants.profileIconIndex):
          // Redirect to profile page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp1()),
          );
          break;
        case (Constants.chatIconIndex):
          // Redirect to chat page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp1()),
          );
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: _handleIconTap,
      items: _items,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
    );
  }
}
