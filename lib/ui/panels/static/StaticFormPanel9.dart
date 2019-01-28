/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'dart:math';

class StaticFormPanel9 extends StatelessWidget {
  final EdgeInsets widgetsMargin = EdgeInsets.all(5.0);
  final widgetPortionCount = 10;
  final List<Widget> panelWidgets = List();
  final Random randomInstance = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Form Panel 9'),
        ),
        body: ListView(children: _buildPanelWidgets()));
  }

  List<Widget> _buildPanelWidgets() {
    _buildEditWidgets();
    _buildRadioWidgets();
    _buildCheckboxWidgets();
    _buildListWidgets();
    _buildDropdownWidgets();
    return panelWidgets;
  }

  void _buildEditWidgets() {
    for (int index = 1; index <= widgetPortionCount; index++) {
      Container editContainer = Container(
          margin: widgetsMargin,
          child: TextFormField(
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'EditControl $index',
                  labelText: 'Edit Control $index')));
      panelWidgets.add(editContainer);
    }
  }

  void _buildRadioWidgets() {
    for (int index = 1; index <= widgetPortionCount; index++) {
      Container radioContainer = Container(
        margin: widgetsMargin,
        child: RadioListTile(
            title: Text('Radio $index'), groupValue: null, value: index, onChanged: null),
      );
      panelWidgets.add(radioContainer);
    }
  }

  void _buildCheckboxWidgets() {
    for (int index = 1; index <= widgetPortionCount; index++) {
      Container checkboxContainer = Container(
        margin: widgetsMargin,
        child: CheckboxListTile(
            title: Text('Checkbox $index'),
            value: randomInstance.nextBool(),
            onChanged: null),
      );
      panelWidgets.add(checkboxContainer);
    }
  }

  void _buildListWidgets() {
    for (int listViewIndex = 1;
        listViewIndex <= widgetPortionCount;
        listViewIndex++) {
      Column singleListView = Column(
          children: List.generate(4, (int itemIndex) {
        if (itemIndex == 0) {
          return Text('List $listViewIndex');
        }
        return Card(
            child: ListTile(
                leading: Icon(Icons.format_list_bulleted),
                title: Text('Item $itemIndex')));
      }));
      panelWidgets.add(singleListView);
    }
  }

  void _buildDropdownWidgets() {
    var dropDownItemValues = <String>['A', 'B', 'C', 'D'];
    for (int index = 1; index <= widgetPortionCount; index++) {
      var randomValue = randomInstance.nextInt(dropDownItemValues.length);
      DropdownButton<String> dropDownButton = DropdownButton<String>(
        value: dropDownItemValues[randomValue],
        items: dropDownItemValues.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      );
      panelWidgets.add(dropDownButton);
    }
  }
}
