import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/home/feed/feed.dart';
import 'package:project_seg/screens/home/profile/profile_page.dart';

class MenuItemData {
  final String title;
  final IconData icon;
  final String routeName;
  final String path;
  final Widget destinationWidget;

  MenuItemData({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.path,
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
      routeName: "profile",
      path: "/profile",
      destinationWidget: ProfilePage(),
    ),
    MenuItemData(
      title: "Feed",
      icon: FontAwesomeIcons.home,
      routeName: "feed",
      path: "/feed",
      destinationWidget: Feed(),
    ),
    MenuItemData(
      title: "Chat",
      icon: FontAwesomeIcons.solidComment,
      routeName: "chat",
      path: "/chat",
      destinationWidget: Container(
        child: const Center(
          child: Text("This is where the chat goes."),
        ),
      ),
    ),
  ],
);
