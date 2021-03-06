/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';

class RibbonButton extends StatelessWidget {
  final String title;
  final GestureTapCallback gestureTapCallback;

  RibbonButton({this.title, this.gestureTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: gestureTapCallback,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Expanded(
                child: Column(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
