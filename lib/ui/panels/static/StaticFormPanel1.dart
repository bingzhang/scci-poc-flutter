/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:profile_demo/utility/StaticHelper.dart';

class StaticFormPanel1 extends StatelessWidget {
  final widgetsCount = 10;
  final List<Widget> panelWidgets = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Form Panel 1'),
        ),
        body: ListView(children: _buildPanelWidgets()));
  }

  List<Widget> _buildPanelWidgets() {
    panelWidgets.addAll(StaticHelper.buildEditWidgets(widgetsCount));
    panelWidgets.addAll(StaticHelper.buildRadioWidgets(widgetsCount));
    panelWidgets.addAll(StaticHelper.buildCheckboxWidgets(widgetsCount));
    panelWidgets.addAll(StaticHelper.buildListWidgets(widgetsCount));
    panelWidgets.addAll(StaticHelper.buildDropdownWidgets(widgetsCount));
    return panelWidgets;
  }
}
