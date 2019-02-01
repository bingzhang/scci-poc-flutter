/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

import 'package:profile_demo/ui/widgets/HeaderAppBar.dart';
import 'package:profile_demo/ui/widgets/HorizontalDivider.dart';
import 'package:profile_demo/ui/widgets/Option.dart';
import 'package:profile_demo/ui/widgets/RibbonButton.dart';
import 'package:profile_demo/ui/widgets/SearchBar.dart';
import 'package:profile_demo/ui/widgets/TimeAndWhetherHeader.dart';

class StudentLifeOnCampusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(context: context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/header_about.jpg",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                ),
                child: Column(
                  children: <Widget>[TimeAndWhetherHeader()],
                ),
              ),
            ),
            HorizontalDivider(),
            RibbonButton(
              title: 'Life on Campus',
            ),
            HorizontalDivider(),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Option(
                    title: 'To Do List',
                  ),
                  Option(
                    title: 'Dining',
                  ),
                  Option(
                    title: 'Events',
                  ),
                  Option(
                    title: 'Navigation',
                  ),
                  Option(
                    title: 'Social',
                  ),
                  Option(
                    title: 'Athletics',
                  ),
                  Option(
                    title: 'Navigation',
                  ),
                  Option(
                    title: 'News',
                  ),
                  Option(
                    title: 'Schedule',
                  ),
                  Option(
                    title: 'Grades',
                  )
                ],
              ),
            ),
            SearchBar()
          ],
        ));
  }
}
