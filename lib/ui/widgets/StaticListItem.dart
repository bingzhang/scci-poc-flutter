/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/model/static/StaticListModel.dart';
import 'package:profile_demo/ui/widgets/RoundedImageButton.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';

class StaticListItem extends RoundedImageButton {
  final StaticListModel data;
  final BuildContext context;

  StaticListItem(this.data, this.context)
      : super(
            text: data.buttonTitle,
            sizeRatio: UiConstants.buttonsAspectRatio,
            visible: true,
            onTapGesture: () {
              _onTapGesture(context, data.url, data.pageTitle);
            });

  static _onTapGesture(BuildContext context, String url, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new WebContentPanel(url: url, title: title)));
  }
}
