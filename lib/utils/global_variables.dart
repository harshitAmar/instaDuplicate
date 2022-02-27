import 'package:flutter/material.dart';
import 'package:insta/screens/add_post_screen.dart';
import 'package:insta/screens/feed_screen.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("notification")),
  Center(child: Text("profile")),
];
