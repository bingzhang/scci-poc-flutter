import 'package:flutter/material.dart';
import 'package:profile_demo/ui/ProfileHomePage.dart';
import 'package:profile_demo/utility/Utils.dart';

void main() {
  runApp(ProfileDemoApp());
  init();
}

void init() {
  AppUtils.generateUserUuidIfNeeded();
}

class ProfileDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UUIC',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 28, 38, 58),
      ),
      home: ProfileHomePage(),
    );
  }
}
