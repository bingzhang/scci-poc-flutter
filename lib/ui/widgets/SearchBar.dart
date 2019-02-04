/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/navigation/NavigationRouter.dart';
import 'package:profile_demo/ui/panels/ProfileEditPanel.dart';
import 'package:profile_demo/utility/Utils.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        color: Colors.black26,
//        color: Color.fromARGB(0, 188, 192, 195),
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
          Expanded(child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          child:Ink(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 134, 134, 134),
                shape: UiConstants.roundedButtonBoxShape,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none
    )               ,
    )           )
          ))),
          Image.asset('images/icon-search.png',
              width: 42, height: 42, fit: BoxFit.cover),
        ]));
  }
}
