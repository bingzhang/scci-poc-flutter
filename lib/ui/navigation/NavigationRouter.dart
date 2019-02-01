/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class NavigationRouter {
  static Function openPanel(BuildContext context, Widget panel) {
    return () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => panel));
    };
  }
}
