import 'package:flutter/material.dart';
import 'package:profile_demo/ui/ProfileHomePage.dart';
import 'package:profile_demo/utility/Utils.dart';

void main() {
  runApp(ProfileDemoApp());
  init();
}

void init() {
  Utils.generateUserUuidIfNeeded();
}

class ProfileDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileHomePage(),
    );
  }
}
