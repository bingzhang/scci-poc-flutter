/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/ui/widgets/ProfileHomeContent.dart';
import 'package:profile_demo/ui/widgets/StudentHomeContent.dart';

class HomePanel extends StatefulWidget {
  @override
  _HomePanelState createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  Role _role;

  @override
  void initState() {
    _initRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_role != null && _role == Role.student)
        ? StudentHomeContent()
        : ProfileHomeContent();
  }

  void _initRole() {
    User user = ProfileLogic().getUser();
    setState(() {
      _role = (user != null) ? user.role : Role.unknown;
    });
  }
}
