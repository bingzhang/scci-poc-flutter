/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/model/static/StaticListModel.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/panels/WebContentPage.dart';

class StaticListItem extends StatelessWidget {
  final StaticListModel data;

  StaticListItem(this.data);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * UiConstants.HOME_BUTTONS_ASPECT_RATIO;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            UiConstants.HOME_BUTTONS_PADDING_W,
            0,
            UiConstants.HOME_BUTTONS_PADDING_W,
            UiConstants.HOME_BUTTONS_SPACING),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
              border: UiConstants.ROUNDED_BUTTON_BORDER,
              color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
              shape: UiConstants.ROUNDED_BUTTON_BOX_SHAPE,
              borderRadius: UiConstants.ROUNDED_BUTTON_BORDER_RADIUS),
          child: InkWell(
            onTap: () {
              _onTapGesture(context, data.url, data.pageTitle);
            },
            child: new Center(child: new Text(data.buttonTitle,style: UiConstants.ROUNDED_TEXT_BUTTON_STYLE)),
          ),
        ));
  }

  _onTapGesture(BuildContext context, String url, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new WebContentPage(url: url, title: title)));
  }
}