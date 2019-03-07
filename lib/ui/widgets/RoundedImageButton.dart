/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/utility/Utils.dart';

class RoundedImageButton extends StatelessWidget {
  final bool visible;
  final String imageType;
  final String imagePath;
  final GestureTapCallback onTapGesture;
  final double sizeRatio;
  final double innerGutter;
  final String text;

  RoundedImageButton(
      {Key key,
      this.visible,
      this.imageType,
      this.imagePath,
      this.onTapGesture,
      this.sizeRatio,
      this.innerGutter = UiConstants.buttonsSpacing,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * sizeRatio;
    return Visibility(
        visible: visible,
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                UiConstants.buttonsPaddingW, 0, UiConstants.buttonsPaddingW, innerGutter),
            child: Ink(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  border: UiConstants.roundedButtonBorder,
                  color: UiConstants.appBrandColor,
                  image: UiUtils.buildDecorationImage(imageType, imagePath),
                  shape: UiConstants.roundedButtonBoxShape,
                  borderRadius: UiConstants.roundedButtonBorderRadius),
              child: InkWell(
                onTap: onTapGesture,
                child: text == null || text.isEmpty
                    ? UiConstants.roundedButtonPadding
                    : new Center(child: new Text(text, style: UiConstants.roundedTextButtonStyle)),
              ),
            )));
  }
}
