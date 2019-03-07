/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_demo/lang/locale/locales.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/logic/UiLogic.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/ui/WidgetHelper.dart';
import 'package:profile_demo/ui/panels/MapsPanel.dart';

class ProfileHomeContent extends StatefulWidget {
  @override
  _ProfileHomeContentState createState() => _ProfileHomeContentState();
}

class _ProfileHomeContentState extends State<ProfileHomeContent> {
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
          title:   GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => new MapsPanel(pos: new LatLng(40.1019523,-88.5073129), title:AppLocalizations.of(context).profileHomeHeaderActionTitle))),
          child: Image.asset(
            'images/illinois_vertical.png',
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
          )
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
              padding: UiLogic().getHomePadding(), child: _buildBodyContent())),
    );
  }

  Widget _buildBodyContent() {
    if (!UiLogic().hasHomePanelDefinition()) {
      return Text(AppLocalizations.of(context).profileHomeErrorMessage);
    }
    List<dynamic> widgets = UiLogic().getHomeWidgets();
    double widgetsInnerGutter = UiLogic().getHomeInnerGutter();
    return ListView(
        children: WidgetHelper.createPanelContentFor(context, widgets,
            widgetsInnerGutter, _userRole, _getEditProfileTapGesture()));
  }

  GestureTapCallback _getEditProfileTapGesture() {
    return () => Navigator.pushNamed(context, '/edit');
  }
}
