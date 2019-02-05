/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';

class SlidePanelRoute extends PageRouteBuilder {
  final Widget widget;
  final bool startFromLeft;

  SlidePanelRoute({this.widget, this.startFromLeft = false})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset((startFromLeft ? 1.0 : -1.0), 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}
