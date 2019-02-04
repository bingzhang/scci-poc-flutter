/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/WidgetHelper.dart';

class Option extends StatelessWidget {
  final dynamic data;

  Option(this.data);

  @override
  Widget build(BuildContext context) {
      GestureTapCallback tapGesture = data!=null ? WidgetHelper.parseWidgetGesture(context, data["destination"]) : GestureTapCallback;

    return GestureDetector(
      onTap: tapGesture,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Title(data["title"]),
          Image.asset(
            'images/icon-option-placeholder.png',
            height: 62,
            width: 62,
          ),

        ],
      ),
    );
  }

  Text _Title(Map<String,dynamic> titleData){
    String text;

    if(titleData!=null){
      text = titleData["text"];
    }
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Avenir',
          fontWeight: FontWeight.w700,
          fontSize: 16),
    );
  }
}
