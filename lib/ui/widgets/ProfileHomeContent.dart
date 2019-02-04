/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/logic/UiLogic.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/ui/WidgetHelper.dart';

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
        title: Image.asset(
          'images/illinois_vertical.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
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
      return Text('Sorry, unable to load UI. Please try again later');
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
