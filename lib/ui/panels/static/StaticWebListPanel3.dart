import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_demo/ui/panels/WebContentPage.dart';
import 'package:profile_demo/utility/Utils.dart';

class StaticWebListPanel3 extends StatelessWidget {
  List<StaticListModel> items;
  StaticWebListPanel3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    items = constructStaticData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Web List 3"),
        ),
        body: new Column(children: <Widget>[
          new Expanded(
              child: new ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return new StaticListItem(items[Index]);
                  }))
        ]));
  }

  //Moc Test Data
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

class StaticListItem extends StatelessWidget {
  StaticListModel data;

  StaticListItem(StaticListModel data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width * UiConstants.HOME_BUTTONS_ASPECT_RATIO;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            UiConstants.HOME_BUTTONS_PADDING_W,
            0,
            UiConstants.HOME_BUTTONS_PADDING_W,
            UiConstants.HOME_BUTTONS_SPACING),
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
              border: UiConstants.ROUNDED_BUTTON_BORDER,
              shape: UiConstants.ROUNDED_BUTTON_BOX_SHAPE,
              borderRadius: UiConstants.ROUNDED_BUTTON_BORDER_RADIUS),
          child: InkWell(
            onTap: () {
              _onTapGesture(context, data.url, data.pageTitle);
            },
            child: new Center(child: new Text(data.buttonTitle)),
          ),
        ));
  }

  _onTapGesture(BuildContext context, String url, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new WebContentPage(url: url, title: title)));
  }
}

class StaticListModel {
  String url;
  String buttonTitle;
  String pageTitle;

  StaticListModel(String url, String buttonTitle, String pageTitle) {
    this.url = url;
    this.buttonTitle = buttonTitle;
    this.pageTitle = pageTitle;
  }
}
