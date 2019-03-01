/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/utility/Utils.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations str = AppLocalizations.of(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
        color: Colors.black26,
//        color: Color.fromARGB(0, 188, 192, 195),
        child: Row(children: <Widget>[
          Semantics(
            button: true,
            excludeSemantics: true,
            label: str.semanticsSearchSettingsLabel,
            hint: str.semanticsSearchSettingsHint,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/edit'),
              child: Image.asset(
                'images/icon-settings.png',
                width: 42,
                height: 42,
                fit: BoxFit.cover,
              ),
            )
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
                  child: 
                  Semantics(
                    textField: true,
                    label: str.semanticsSearchFieldLabel,
                    hint: str.semanticsSearchFieldHint,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none
    )               ,
    )           ))
          ))),
          Semantics(
            button: true,
            excludeSemantics: true,
            label: str.semanticsSearchFieldLabel,
            hint: str.semanticsSearchButtonHint,
            child: Image.asset('images/icon-search.png',
              width: 42, height: 42, fit: BoxFit.cover),
                    )
        ]));
  }
}
