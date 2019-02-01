/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';

class StudentLifeOnCampusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(
          children: <Widget>[Text('Life on campus')],
        ));
  }
}
