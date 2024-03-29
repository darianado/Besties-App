import 'package:flutter/material.dart';
import 'package:project_seg/models/Navigation/menu_data.dart';
import 'package:project_seg/constants/colours.dart';

/// A widget that displays a list of [BottomNavigationBarItem] in a [BottomNavigationBar].
class NavBar extends StatelessWidget {
  final MenuData menuData;
  final Function(int index) onPressed;
  final int selectedIndex;

  const NavBar(
      {Key? key,
      required this.menuData,
      required this.onPressed,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _items = menuData.entries
        .map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
        .toList();

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onPressed,
      items: _items,
      selectedItemColor: tertiaryColour,
      unselectedItemColor: greyShadeDark,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
    );
  }
}
