/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/ui/WidgetHelper.dart';
import 'package:profile_demo/utility/Utils.dart';

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
          _Image(data["image"]),
        ],
      ),
    );
  }

  //TODO move in Utils
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

  Widget _Image(Map<String,dynamic> imageData){
    Widget defaultImage = Image.asset(
      'images/icon-option-placeholder.png',
      height: 62,
      width: 62,
    );
//    return defaultImage;
    if(imageData!=null)
      return parseImage(imageData,62.0,62.0);
    else
      return Text("");
  }

  static Widget parseImage(Map<String, dynamic> imageData,double defaultWidth, defaultHeight){
    String imageType;
    String imagePath;
    double width;
    double height;
    if (imageData != null) {
      imageType = imageData['type'];
      imagePath = imageData['path'];
      width  = imageData['width']!=null ?  AppUtils.parseDoubleFrom(imageData["width"]) : defaultWidth;
      height = imageData['height']!=null ?  AppUtils.parseDoubleFrom(imageData["height"]) : defaultHeight;
    }
    return Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: UiUtils.buildDecorationImage(imageType, imagePath),
            border: UiConstants.emptyBorder,
            color: Colors.transparent,
            shape: UiConstants.roundedButtonBoxShape,
            borderRadius: BorderRadius.zero
        )
    );

  }
}
