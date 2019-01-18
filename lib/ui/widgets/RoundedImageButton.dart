import 'package:flutter/material.dart';
import 'package:profile_demo/utility/Utils.dart';

class RoundedImageButton extends StatelessWidget {
  final String imageRelativePath;
  final GestureTapCallback onTapGesture;

  RoundedImageButton({Key key, this.imageRelativePath, this.onTapGesture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          border: UiConstants.ROUNDED_BUTTON_BORDER,
          image: UiUtils.buildDecorationImage(imageRelativePath),
          shape: UiConstants.ROUNDED_BUTTON_BOX_SHAPE,
          borderRadius: UiConstants.ROUNDED_BUTTON_BORDER_RADIUS),
      child: InkWell(
        onTap: onTapGesture,
        child: UiConstants.ROUNDED_BUTTON_PADDING,
      ),
    );
  }
}