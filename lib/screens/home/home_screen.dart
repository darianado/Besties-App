import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Navigation/menu_data.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/// A widget that helps navigating through the pages connected by the [NavBar].
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

  /// Updates the selected index in the [NavBar].
  set selectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    final _matchState = Provider.of<MatchState>(context, listen: false);
    final _userState = Provider.of<UserState>(context, listen: false);

    _matchState.onStart(_userState.user!.user!.uid);
    selectedIndex = widget.index;
    super.initState();
  }

  /// Changes the [index] of the selected [NavBar] item.
  void changeSelection(int index) {
    if (index == 1) {
      FeedScreen.animateToTop();
    }

    selectedIndex = index;

    context.goNamed(homeScreenName, params: {pageParameterKey: menuData.routeNameOfItemWithIndex(index)});
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    selectedIndex = widget.index;
    super.didUpdateWidget(oldWidget);
  }

  /// Returns the screens connected by the [NavBar].
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
