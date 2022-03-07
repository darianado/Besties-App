import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/Personal_information/profile_page.dart';
import 'package:project_seg/Sign_Up/register_screen.dart';
import 'package:project_seg/models/Navigation/MenuData.dart';
/*
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
        icon: Icon(Icons.textsms_outlined),
        activeIcon: Icon(Icons.textsms),
        label: 'chats',
      ),
    ];

    // Updates the navbar's icon index navigates to the new page
    void _handleIconTap(int index) {
      setState(() {
        widget.currentIndex = index;
      });

      switch (widget.currentIndex) {
        case (kProfileIconIndex):
          // Redirect to profile page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
          break;
        case (kChatIconIndex):
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
*/

class NavBar extends StatelessWidget {
  final MenuData menuData;
  final Function(int index) onPressed;
  final int selectedIndex;

  const NavBar({Key? key, required this.menuData, required this.onPressed, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _items =
        menuData.entries.map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title)).toList();

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onPressed,
      items: _items,
      selectedItemColor: kTertiaryColour,
      unselectedItemColor: Colors.grey.shade500,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
    );
  }
}
