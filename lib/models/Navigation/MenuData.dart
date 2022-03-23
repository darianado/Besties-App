import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/chat/contact_page.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';

class MenuItemData {
  final String title;
  final IconData icon;
  final String routeName;
  final Widget destinationWidget;

  MenuItemData({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.destinationWidget,
  });
}

class MenuData {
  final List<MenuItemData> entries;

  MenuData({required this.entries});

  List<MenuItemData> get items => entries.whereType<MenuItemData>().toList();

  int indexOfItemWithRoute(String routeName) => items.indexWhere((element) => element.routeName == routeName);
}

MenuData menuData = MenuData(
  entries: [
    MenuItemData(
      title: "Profile",
      icon: FontAwesomeIcons.solidUserCircle,
      routeName: profileScreenName,
      destinationWidget: ProfileScreen(),
    ),
    MenuItemData(
      title: "Feed",
      icon: FontAwesomeIcons.home,
      routeName: feedScreenName,
      destinationWidget: FeedScreen(),
    ),
    MenuItemData(
      title: "Chat",
      icon: FontAwesomeIcons.solidComment,
      routeName: chatScreenName,
      destinationWidget: Contact_Page(),
    ),
  ],
);
