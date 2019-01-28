/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/panels/ProfileHomePage.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';

void main() async {
  await init();
  runApp(ProfileDemoApp());
}

Future<void> init() async {
  await AppUtils.generateUserUuidIfNeeded();
  await ProfileLogic().loadUser();
}

class ProfileDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UIUC',
      theme: ThemeData(
        primaryColor: UiConstants.APP_BRAND_COLOR,
      ),
      home: ProfileHomePage(),
    );
  }
}
