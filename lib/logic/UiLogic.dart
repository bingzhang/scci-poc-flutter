/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/ui/widgets/ProfileHomeContent.dart';
import 'package:profile_demo/utility/Utils.dart';

class UiLogic {
  static final UiLogic _logic = new UiLogic._internal();
  String _configLanguage;

  Map<String, dynamic> _uiSettingsJson;

  factory UiLogic() {
    return _logic;
  }

  UiLogic._internal();

  Future<void> loadLocalizedUiConfig(String locale) async {
    print("localization config last: $_configLanguage : new: $locale");
    if(_configLanguage == locale){
      return;
    }
    String uiSettingsToString = await ServerRequest.loadUiConfigWithLanguage(locale);

    if (AppUtils.isStringEmpty(uiSettingsToString)) {
      return;
    }
    _configLanguage = locale;
    print("localization config stored: $_configLanguage");
    _uiSettingsJson = await json.decode(uiSettingsToString);
  }

  static const platform = const MethodChannel("com.uiuc.profile/native_call");
  Future<void> loadUiConfig() async {
    String language = await platform.invokeMethod('language');
    return loadLocalizedUiConfig(language);
  }

  Map<String, dynamic> get uiSettingsJson => _uiSettingsJson;

  EdgeInsets getHomePadding() {
    Map<String, dynamic> marginJson = _marginHome;
    if (marginJson == null) {
      return EdgeInsets.all(0);
    }
    double left = AppUtils.parseDoubleFrom(marginJson['left']);
    double top = AppUtils.parseDoubleFrom(marginJson['top']);
    double right = AppUtils.parseDoubleFrom(marginJson['right']);
    double bottom = AppUtils.parseDoubleFrom(marginJson['bottom']);
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  double getHomeInnerGutter() {
    if (!hasHomePanelDefinition()) {
      return 0.0;
    }
    return AppUtils.parseDoubleFrom(_homePanelJson['inner_gutter']);
  }

  bool hasHomePanelDefinition() {
    return (_homePanelJson != null);
  }

  List<dynamic> getHomeWidgets() {
    if (!hasHomePanelDefinition()) {
      return null;
    }
    return _homePanelJson['widgets'];
  }

  Map<String, dynamic> get _panelsJson {
    if (uiSettingsJson == null) {
      return null;
    }
    return uiSettingsJson['panels'];
  }

  Map<String, dynamic> get _homePanelJson {
    if (_panelsJson == null) {
      return null;
    }
    return _panelsJson['home'];
  }

  Map<String, dynamic> get _marginHome {
    if (!hasHomePanelDefinition()) {
      return null;
    }
    return _homePanelJson['margin'];
  }

  Map<String, dynamic> get _studentLifeInCampusJson{
    if (_panelsJson == null) {
      return null;
    }
    return _panelsJson['studentLifeInCampus'];
  }

  List<dynamic> getStudentLifeInCampusGrid() {
    if (_studentLifeInCampusJson==null) {
      return null;
    }
    return _studentLifeInCampusJson['grid'];
  }

}
