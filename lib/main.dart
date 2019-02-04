/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/panels/ProfileHomePanel.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/logic/UiLogic.dart';

void main() async {
  await init();
  runApp(ProfileDemoApp());
}

Future<void> init() async {
  await ProfileLogic().loadUser();
  await UiLogic().loadUiConfig();
}

class ProfileDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UIUC',
      theme: ThemeData(
        primaryColor: UiConstants.appBrandColor,
      ),
      home: ProfileHomePanel(),
    );
  }
}
