/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';

class HeaderAppBar extends AppBar {
  final BuildContext context;

  HeaderAppBar({@required this.context})
      : super(actions: <Widget>[
          IconButton(
            icon: Image.asset('images/icon-illinois.png'),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebContentPanel(
                        url: 'https://illinois.edu', title: 'UIUC'))),
          )
        ], centerTitle: true, title: Text('SAVVI'));
}
