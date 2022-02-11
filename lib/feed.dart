import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'dart:math' as math;

// Constant that identifies the feed icon index in the nav bar 
const feedIconIndex = 1;

// This method generates n containers to fill the PageView with random colours
void fillContainers(List<Container> containers, BuildContext context) {
  for (int i = 0; i < 100; i++) {
    int randomHex = (math.Random().nextDouble() * 0xFFFFFF).toInt();
    Container container = Container(
      height: MediaQuery.of(context).size.height,
      color: Color(randomHex).withOpacity(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Name Surname\n" + randomHex.toString(),
            style: const TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
    containers.add(container);
  }
}

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Container> containers = [];

  @override
  Widget build(BuildContext context) {
    fillContainers(containers, context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: const BackButton(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: containers,
      ),
      bottomNavigationBar: NavBar(currentIndex: feedIconIndex,),
    );
  }
}
