/*
 * Copyright (c) 2019 Illinois. All rights reserved.
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
          _title(data["title"]),
          _image(data["image"]),
        ],
      ),
    );
  }

  Text _title(Map<String,dynamic> titleData){
    String text;
    int textColor = 0xff000000; //default
    String fontFamily = 'Avenir';
    double fontSize = 16.0;
    String fontWeight = "normal"; //bolt
    String fontStyle = "normal"; //bolt

    if(titleData!=null){
      text = titleData["text"];
      String textColorString = titleData["text-color"];
      if(textColorString!=null){
        textColor = int.parse(textColorString);
      }
      Map<String, dynamic> fontData = titleData["font"];
      if(fontData!=null){
        fontFamily = fontData.containsKey("family")? fontData["family"] : fontFamily;
        fontSize = fontData.containsKey("size")? AppUtils.parseDoubleFrom(fontData["size"]) : fontSize;
        fontWeight = fontData.containsKey("weight")? fontData["weight"] : fontWeight;
        fontStyle = fontData.containsKey("style")? fontData["style"] : fontStyle;
      }

    }
    return Text(
      text,
      style: TextStyle(
          color: Color(textColor),
          fontFamily: fontFamily,
          fontStyle: AppUtils.fontStyleFromString(fontStyle),
          fontWeight: AppUtils.fontWeightFromString(fontWeight),
          fontSize: fontSize),
    );
  }

  Widget _image(Map<String,dynamic> imageData){
    if(imageData!=null)
      return parseImage(imageData,62.0,62.0);
    else
      return Container();
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
    return Container(
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
