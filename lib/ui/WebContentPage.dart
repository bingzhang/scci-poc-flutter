import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebContentPage extends StatefulWidget {
  String url;
  String title;
  WebContentPage(String url, String title){
    this.url = url;
    this.title = title;
  }

  @override
  _WebContentPageState createState() => _WebContentPageState(url,title);
}

class _WebContentPageState extends State<WebContentPage> {
  String url;
  String title;

  _WebContentPageState(String url, String title){
    this.url = url;
    this.title = title;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      )
    );
  }
}