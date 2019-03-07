/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';

class HeaderAppBar extends AppBar {
  final BuildContext context;

  HeaderAppBar({@required this.context})
      : super(
            actions: <Widget>[
              Semantics(
                excludeSemantics: true,
                button: true,
                hint: AppLocalizations.of(context).semanticsHeaderHint,
                child: IconButton(
                  icon: Image.asset('images/icon-illinois.png'),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebContentPanel(
                              url: 'https://illinois.edu', title: 'Illinois'))),
                ),
              )
            ],
            centerTitle: true,
            title: Semantics(
              excludeSemantics: true,
              label: AppLocalizations.of(context).semanticsHeaderLabel,
              header: true,
              child: Text('Illinois'),
            ));
}
