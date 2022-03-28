import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Navigation/menu_data.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  int index;
  HomeScreen({Key? key, required String page})
      : index = menuData.indexOfItemWithRoute(page),
        super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  set selectedIndex(int index) {
    setState(() {
      widget.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final _matchState = MatchState.instance;
    final _userState = UserState.instance;

    _matchState.onStart(_userState.user?.user?.uid ?? "abc123");
    selectedIndex = widget.index;
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    selectedIndex = widget.index;
    super.didUpdateWidget(oldWidget);
  }

  void changeSelection(int index) {
    if (index == 1) {
      FeedScreen.animateToTop();
    }

    setState(() {
      widget.index = index;
    });

    final destination = menuData.pathOfItemWithIndex(widget.index);
    context.go(destination);
  }

  List<Widget> get itemWidgets => menuData.items.map((e) => e.destinationWidget).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.index,
        children: itemWidgets,
      ),
      bottomNavigationBar: NavBar(
        menuData: menuData,
        selectedIndex: widget.index,
        onPressed: changeSelection,
      ),
    );
  }
}
