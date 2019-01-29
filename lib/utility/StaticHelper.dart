/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:profile_demo/model/static/StaticListModel.dart';

class StaticHelper {
  static final EdgeInsets widgetsMargin = EdgeInsets.all(5.0);
  static final Random randomInstance = new Random();

  static List<Widget> buildEditWidgets(int widgetsCount) {
    List<Widget> editWidgets = List();
    for (int index = 1; index <= widgetsCount; index++) {
      Container editContainer = Container(
          margin: widgetsMargin,
          child: TextFormField(
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'EditControl $index',
                  labelText: 'Edit Control $index')));
      editWidgets.add(editContainer);
    }
    return editWidgets;
  }

  static List<Widget> buildRadioWidgets(int widgetsCount) {
    List<Widget> radioWidgets = List();
    for (int index = 1; index <= widgetsCount; index++) {
      Container radioContainer = Container(
        margin: widgetsMargin,
        child: RadioListTile(
            title: Text('Radio $index'),
            groupValue: null,
            value: index,
            onChanged: null),
      );
      radioWidgets.add(radioContainer);
    }
    return radioWidgets;
  }

  static List<Widget> buildCheckboxWidgets(int widgetsCount) {
    List<Widget> checkboxWidgets = List();
    for (int index = 1; index <= widgetsCount; index++) {
      Container checkboxContainer = Container(
        margin: widgetsMargin,
        child: CheckboxListTile(
            title: Text('Checkbox $index'),
            value: randomInstance.nextBool(),
            onChanged: null),
      );
      checkboxWidgets.add(checkboxContainer);
    }
    return checkboxWidgets;
  }

  static List<Widget> buildListWidgets(int widgetsCount) {
    List<Widget> listWidgets = List();
    for (int listViewIndex = 1;
        listViewIndex <= widgetsCount;
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
      listWidgets.add(singleListView);
    }
    return listWidgets;
  }

  static List<Widget> buildDropdownWidgets(int widgetsCount) {
    List<Widget> dropdownWidgets = List();
    var dropDownItemValues = <String>['A', 'B', 'C', 'D'];
    for (int index = 1; index <= widgetsCount; index++) {
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
      dropdownWidgets.add(dropDownButton);
    }
    return dropdownWidgets;
  }

  static List<StaticListModel> constructWebWidgetsData() {
    int size = 50;
    List<StaticListModel> result = new List();
    for (int i = 0; i < size; i++) {
      result.add(
          new StaticListModel("https://www.bing.com/search?q=$i", "Web Button $i", "Web $i"));
    }
    return result;
  }
}
