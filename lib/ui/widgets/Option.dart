/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final String title;
  final GestureTapCallback tapCallback;

  Option({this.title, this.tapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/icon-option-placeholder.png',
            height: 62,
            width: 62,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.w700,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}
