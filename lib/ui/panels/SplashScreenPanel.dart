/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/utility/Utils.dart';

class SplashScreenPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiConstants.appBrandColor,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'images/illinois_vertical.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
