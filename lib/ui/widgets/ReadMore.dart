/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class ReadMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: <Widget>[
      Text('read more', style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w800, fontSize: 14, color: Colors.black),),
      Image.asset('images/icon-chevron-down.png', width: 18, height: 12, fit: BoxFit.cover),
    ],),);
  }
}
