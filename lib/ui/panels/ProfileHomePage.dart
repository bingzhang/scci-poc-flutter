/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel1.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel10.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel2.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel3.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel4.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel5.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel6.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel7.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel8.dart';
import 'package:profile_demo/ui/panels/static/StaticFormPanel9.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel1.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel10.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel2.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel3.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel4.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel5.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel6.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel7.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel8.dart';
import 'package:profile_demo/ui/panels/static/StaticWebListPanel9.dart';
import 'package:profile_demo/ui/widgets/RoundedTextButton.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/ui/panels/ProfileEditPage.dart';
import 'package:profile_demo/ui/panels/WebContentPage.dart';
import 'package:profile_demo/ui/widgets/RoundedImageButton.dart';

class ProfileHomePage extends StatefulWidget {
  ProfileHomePage({Key key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  Role _userRole;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadUser() {
    final User user = ProfileLogic().getUser();
    setState(() {
      _userRole = (user != null) ? user.role : Role.unknown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset(
          'images/illinois_vertical.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, UiConstants.HOME_TOP_SPACING, 0, 0),
              child: ListView(
                children: <Widget>[
                  RoundedImageButton(
                      visible: true,
                      imageRelativePath: 'images/campus.jpg',
                      sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                      onTapGesture: () {
                        _openWeb("Getting Around",
                            "https://goo.gl/maps/vc7DRLgiMM22");
                      }),
                  RoundedImageButton(
                      visible: (_userRole == Role.student),
                      imageRelativePath: 'images/Bardeen-Quad2.jpg',
                      sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                      onTapGesture: () {
                        _openWeb("General Info",
                            "http://catalog.illinois.edu/general-information/");
                      }),
                  RoundedImageButton(
                      visible: true,
                      imageRelativePath: 'images/athletics.jpg',
                      sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                      onTapGesture: () {
                        _openWeb("Athletics", "https://fightingillini.com/");
                      }),
                  RoundedImageButton(
                      visible: ((_userRole == Role.student) ||
                          (_userRole == Role.staff)),
                      imageRelativePath: 'images/krannert.jpg',
                      sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                      onTapGesture: () {
                        _openWeb(
                            "Events", "https://krannertcenter.com/calendar");
                      }),
                  RoundedImageButton(
                      visible: (_userRole == Role.student),
                      imageRelativePath: 'images/Altgeld.jpg',
                      sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                      onTapGesture: () {
                        _openWeb("Schedule",
                            "https://courses.illinois.edu/schedule/DEFAULT/DEFAULT");
                      }),
                  RoundedImageButton(
                    visible: true,
                    imageRelativePath: 'images/Illinois.jpg',
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEditPage()))
                        .then((value) => _loadUser()),
                  ),
                  //STATIC PANELS
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 1",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel1());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 2",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel2());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 3",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel3());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 4",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel4());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 5",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel5());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 6",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel6());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 7",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel7());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 8",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel8());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 9",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel9());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 10",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticFormPanel10());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 11",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel1());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 12",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel2());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 13",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel3());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 14",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel4());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 15",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel5());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 16",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel6());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 17",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel7());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 18",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel8());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 19",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel9());
                    }
                  ),
                  RoundedTextButton(
                    visible: (_userRole == Role.staff),
                    text: "Static Panel 20",
                    sizeRatio: UiConstants.HOME_BUTTONS_ASPECT_RATIO,
                    onTapGesture: () {
                      _openPanel(StaticWebListPanel10());
                    }
                  ),
                ],
              ))),
    );
  }

  void _openPanel(Widget panel){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => panel));
  }

  void _openWeb(String title, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new WebContentPage(url: url, title: title)));
  }
}