import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedContent extends ChangeNotifier {
  List<Widget>? content;

  FeedContent._privateConstructor();
  static final FeedContent _instance = FeedContent._privateConstructor();
  static FeedContent get instance => _instance;
}
