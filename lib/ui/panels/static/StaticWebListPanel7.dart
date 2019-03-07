/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/model/static/StaticListModel.dart';
import 'package:profile_demo/ui/widgets/StaticListItem.dart';
import 'package:profile_demo/utility/StaticHelper.dart';

class StaticWebListPanel7 extends StatelessWidget {
  final List<StaticListModel> items;

  StaticWebListPanel7() : items = StaticHelper.constructWebWidgetsData();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Web List 7"),
        ),
        body: new Column(children: <Widget>[
          new Expanded(
              child: new ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return new StaticListItem(items[index],context);
                  }))
        ]));
  }
}
