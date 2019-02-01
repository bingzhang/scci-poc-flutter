/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/navigation/NavigationRouter.dart';
import 'package:profile_demo/ui/panels/ProfileEditPanel.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
        color: Colors.black26,
        child: Row(children: <Widget>[
          GestureDetector(
            onTap: NavigationRouter.openPanel(context, ProfileEditPanel()),
            child: Image.asset(
              'images/icon-settings.png',
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(child: TextFormField()),
          Image.asset('images/icon-search.png',
              width: 42, height: 42, fit: BoxFit.cover),
        ]));
  }
}
