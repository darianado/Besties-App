import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/feed.dart';
import 'package:project_seg/landingPage.dart';
import 'package:project_seg/models/my_user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return LandingPage();
    } else {
      return Feed();
    }
  }
}
