/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/model/static/StaticListModel.dart';
import 'package:profile_demo/ui/widgets/StaticListItem.dart';

class StaticWebListPanel5 extends StatelessWidget {
  final List<StaticListModel> items;

  StaticWebListPanel5() : items = StaticListModel.constructStaticData();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Web List 5"),
        ),
        body: new Column(children: <Widget>[
          new Expanded(
              child: new ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return new StaticListItem(items[index]);
                  }))
        ]));
  }
}
