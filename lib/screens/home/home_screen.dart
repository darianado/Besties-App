import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Navigation/MenuData.dart';
import 'package:project_seg/models/profile_container.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

int indexOfItemWithName(String pageName) {
  if (pageName == "profile") {
    return 0;
  } else if (pageName == "feed") {
    return 1;
  } else {
    return 2;
  }
}

String pathOfIndex(int index) {
  if (index == 0) {
    return "profile";
  } else if (index == 1) {
    return "feed";
  } else {
    return "chat";
  }
}

class HomeScreen extends StatefulWidget {
  final int index;
  HomeScreen({Key? key, required String page})
      : index = indexOfItemWithName(page),
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

  void changeSelection(int index) {
    context.go("/" + pathOfIndex(index));
  }

  List<Widget> get itemWidgets => menuData.items.map((e) => e.destinationWidget).toList();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

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
