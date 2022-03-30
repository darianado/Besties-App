import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Navigation/menu_data.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';

/**
 * The Home screen.
 * This screen that helps navigating through the pages that are connected
 * by the Nav Bar (Profile, Feed, Chat history).
 * The page displays its specific content and the NavBar
 */

class HomeScreen extends StatefulWidget {
  final int index;
  HomeScreen({Key? key, required String page})
      : index = menuData.indexOfItemWithRoute(page),
        super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  set selectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    selectedIndex = widget.index;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    selectedIndex = widget.index;
    super.didUpdateWidget(oldWidget);
  }

  /**
   * This method helps navigating through the pages linked by the NavBar.
   * @param int index - the index of the page users select to go to
   */
  void changeSelection(int index) {
    if (index == 1) {
      FeedScreen.animateToTop();
    }

    selectedIndex = index;

    final destination = menuData.pathOfItemWithIndex(_selectedIndex);
    context.go(destination);
  }

  List<Widget> get itemWidgets => menuData.items.map((e) => e.destinationWidget).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: itemWidgets,
      ),
      bottomNavigationBar: NavBar(
        menuData: menuData,
        selectedIndex: _selectedIndex,
        onPressed: changeSelection,
      ),
    );
  }
}
