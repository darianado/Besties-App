import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Navigation/menu_data.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * The Home screen.
 * This screen that helps navigating through the pages that are connected
 * by the [NavBar] ([Profile], [Feed], [Chat] history).
 * The page displays its specific content and the [NavBar].
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
    final _matchState = Provider.of<MatchState>(context, listen: false);
    final _userState = Provider.of<UserState>(context, listen: false);

    _matchState.onStart(_userState.user?.user?.uid ?? "abc123");
    selectedIndex = widget.index;
    super.initState();
  }

  void changeSelection(int index) {
    if (index == 1) {
      FeedScreen.animateToTop();
    }

    selectedIndex = index;
  }

  List<Widget> get itemWidgets =>
      menuData.items.map((e) => e.destinationWidget).toList();

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
