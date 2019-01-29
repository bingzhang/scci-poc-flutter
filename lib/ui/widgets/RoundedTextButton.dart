
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/utility/Utils.dart';

class RoundedTextButton extends StatelessWidget {
  final bool visible;
  final String text;
  final GestureTapCallback onTapGesture;
  final double sizeRatio;
  RoundedTextButton(
      {Key key, this.visible, this.text, this.onTapGesture, this.sizeRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width*sizeRatio;
    return Visibility(
        visible: visible,
        child: Padding(
            padding:
            EdgeInsets.fromLTRB(UiConstants.HOME_BUTTONS_PADDING_W, 0, UiConstants.HOME_BUTTONS_PADDING_W, UiConstants.HOME_BUTTONS_SPACING),
            child: Ink(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  border: UiConstants.ROUNDED_BUTTON_BORDER,
                  color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                  shape: UiConstants.ROUNDED_BUTTON_BOX_SHAPE,
                  borderRadius: UiConstants.ROUNDED_BUTTON_BORDER_RADIUS),
              child: InkWell(
                onTap: onTapGesture,
                child:  new Center(child: new Text(text,style: UiConstants.ROUNDED_TEXT_BUTTON_STYLE)),
              ),
            )));
  }
}