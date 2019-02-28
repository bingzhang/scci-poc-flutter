/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/UiLogic.dart';
import 'package:profile_demo/ui/WidgetHelper.dart';

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
              title: AppLocalizations.of(context).studentLifeCampusTitle,
            ),
            HorizontalDivider(),
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                children: _buildGridContent(context),
              ),
            ),
            SearchBar()
          ],
        ));
  }

  List<Widget> _buildGridContent(BuildContext context){
    List<Widget> widgetsList = List();
    List<dynamic> widgets = UiLogic().getStudentLifeInCampusGrid();
    if(widgets!=null){
      widgets.forEach((widgetEntry) {
        widgetsList.add(Option(widgetEntry));
      });
    } else {
      widgetsList.add(new Text(""));
    }
    return widgetsList;
  }
}
