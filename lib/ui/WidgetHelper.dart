/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/ui/panels/MapsPanel.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/widgets/RoundedImageButton.dart';
import 'package:profile_demo/ui/panels/WebContentPanel.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel1.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel2.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel3.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel4.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel5.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel6.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel7.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel8.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel9.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel10.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel1.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel2.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel3.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel4.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel5.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel6.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel7.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel8.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel9.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel10.dart';

class WidgetHelper {
  static List<Widget> createPanelContentFor(BuildContext context, List<dynamic> widgets, double widgetsInnerGutter,
      Role role, GestureTapCallback editProfileTapGesture) {
    if (widgets == null || widgets.isEmpty) {
      return null;
    }
    List<Widget> widgetsList = List();
    widgets.forEach((widgetEntry) {
      Map<String, dynamic> widgetDestination = widgetEntry['destination'];
      String destinationType;
      String destinationValue;
      String destinationTitle;
      if (widgetDestination != null) {
        destinationType = widgetDestination['type'];
        destinationValue = widgetDestination['value'];
        destinationTitle = widgetDestination['title'];
      }
      Map<String, dynamic> widgetImage = widgetEntry['image'];
      String imageType;
      String imagePath;
      if (widgetImage != null) {
        imageType = widgetImage['type'];
        imagePath = widgetImage['path'];
      }
      String widgetTitle = widgetEntry['title'];
      List<dynamic> roles = widgetEntry['roles'];
      bool widgetVisible = _getWidgetVisibility(roles, role);
      GestureTapCallback tapGesture;
      if (destinationType == 'panel' && destinationValue == 'edit') {
        //special treatment
        tapGesture = editProfileTapGesture;
      } else {
        tapGesture = _getTapGesture(context, destinationType, destinationValue, destinationTitle);
      }
      Widget currentWidget = RoundedImageButton(
          visible: widgetVisible,
          onTapGesture: tapGesture,
          imageType: imageType,
          imagePath: imagePath,
          sizeRatio: UiConstants.buttonsAspectRatio,
          innerGutter: widgetsInnerGutter,
          text: widgetTitle);
      widgetsList.add(currentWidget);
    });
    return widgetsList;
  }

  static bool _getWidgetVisibility(List<dynamic> rolesList, Role userRole) {
    if (rolesList == null || rolesList.isEmpty) {
      return false;
    }
    if (rolesList.contains('all')) {
      return true;
    }
    String userRoleToString = AppUtils.userRoleToString(userRole);
    return (rolesList.contains(userRoleToString));
  }

  static GestureTapCallback parseWidgetGesture(BuildContext context, Map<String, dynamic> widgetDestination){
    String destinationType;
    String destinationValue;
    String destinationTitle;
    if (widgetDestination != null) {
      destinationType = widgetDestination['type'];
      destinationValue = widgetDestination['value'];
      destinationTitle = widgetDestination['title'];
    }
    return _getTapGesture(context, destinationType, destinationValue, destinationTitle);
  }

  static GestureTapCallback _getTapGesture(
        BuildContext context, String destinationType, String destinationValue, String destinationTitle) {
      if (AppUtils.isStringEmpty(destinationType)) {
        return null;
      }
      GestureTapCallback tapGesture;
      if (destinationType == 'panel') {
        Widget panel = _getPanelById(destinationValue);
        tapGesture = () {
          _openPanel(context, panel);
        };
      } else if (destinationType == 'web') {
        tapGesture = () {
          _openWebPanel(context, destinationTitle, destinationValue);
        };
      } else if (destinationType == 'map'){
        tapGesture = () {
          _openMapsPanel(context, destinationTitle, destinationValue);
        };
      }
      return tapGesture;
    }

  static void _openPanel(BuildContext context, Widget panel) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => panel));
    }

  static void _openWebPanel(BuildContext context, String title, String url) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => new WebContentPanel(url: url, title: title)));
    }

  static void _openMapsPanel(BuildContext context, String title, String destination) {
    List<String> latlong =  destination.split(",");
    double latitude = double.tryParse(latlong[0]);
    double longitude = double.tryParse(latlong[1]);
    LatLng location = new LatLng(latitude, longitude);

    Navigator.push(context, MaterialPageRoute(builder: (context) => new MapsPanel(pos:location,title: title)));
  }

  static Widget _getPanelById(String panelId) {
      if (AppUtils.isStringEmpty(panelId)) {
        return null;
      }
      switch (panelId) {
        case 'form_panel_1':
          return StaticFormPanel1();
        case 'form_panel_2':
          return StaticFormPanel2();
        case 'form_panel_3':
          return StaticFormPanel3();
        case 'form_panel_4':
          return StaticFormPanel4();
        case 'form_panel_5':
          return StaticFormPanel5();
        case 'form_panel_6':
          return StaticFormPanel6();
        case 'form_panel_7':
          return StaticFormPanel7();
        case 'form_panel_8':
          return StaticFormPanel8();
        case 'form_panel_9':
          return StaticFormPanel9();
        case 'form_panel_10':
          return StaticFormPanel10();

        case 'web_panel_1':
          return StaticWebListPanel1();
        case 'web_panel_2':
          return StaticWebListPanel2();
        case 'web_panel_3':
          return StaticWebListPanel3();
        case 'web_panel_4':
          return StaticWebListPanel4();
        case 'web_panel_5':
          return StaticWebListPanel5();
        case 'web_panel_6':
          return StaticWebListPanel6();
        case 'web_panel_7':
          return StaticWebListPanel7();
        case 'web_panel_8':
          return StaticWebListPanel8();
        case 'web_panel_9':
          return StaticWebListPanel9();
        case 'web_panel_10':
          return StaticWebListPanel10();
        default:
          return null;
      }
    }
}
