/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

class StaticListModel {
  String url;
  String buttonTitle;
  String pageTitle;

  StaticListModel(String url, String buttonTitle, String pageTitle) {
    this.url = url;
    this.buttonTitle = buttonTitle;
    this.pageTitle = pageTitle;
  }

  static List<StaticListModel> constructStaticData() {
    int size = 50;
    List<StaticListModel> result = new List();
    for (int i = 0; i < size; i++) {
      result.add(
          new StaticListModel("http://google.com", "Web Button $i", "Web $i"));
    }
    return result;
  }
}