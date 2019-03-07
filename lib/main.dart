/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:profile_demo/ui/panels/HomePanel.dart';
import 'package:profile_demo/ui/panels/ProfileEditPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentEventsPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentLifeInCampusPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentUpToDateInfoPanel.dart';
import 'package:profile_demo/ui/panels/student/StudentSchedulePanel.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/logic/UiLogic.dart';

void main() async {
  await _init();
  runApp(ProfileDemoApp());
}

Future<void> _init() async {
  await ProfileLogic().loadUser();
  await UiLogic().loadUiConfig();
}

class ProfileDemoApp extends StatefulWidget {

  ProfileDemoAppState createState() => ProfileDemoAppState();
}

class ProfileDemoAppState extends State<ProfileDemoApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        localizationsDelegates: [
          AppLocalizationsDelegate(context,_onLocaleChanged),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("en"), Locale("es"), Locale("zh")],
        onGenerateTitle: (context) => AppLocalizations.of(context).illinoisTitle,
        theme: ThemeData(
          primaryColor: UiConstants.appBrandColor,
        ),
        home: HomePanel(),
        routes: {
          '/edit': (context) => ProfileEditPanel(),
          '/student/events': (context) => StudentEventsPanel(),
          '/student/campus': (context) => StudentLifeOnCampusPanel(),
          '/student/info': (context) => StudentUpToDateInfoPanel(),
          '/student/schedule': (context) => StudentSchedulePanel(),
        });
  }
  _onLocaleChanged(String locale){
    //reload the config
      UiLogic().loadLocalizedUiConfig(locale).then((_bool){
        refresh();
      });
  }

  refresh(){
    setState(() {

    });
  }
}

