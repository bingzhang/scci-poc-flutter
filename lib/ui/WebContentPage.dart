import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebContentPage extends StatelessWidget {
  final String url;
  final String title;

  WebContentPage({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      hidden: true,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(title),
      ),
    );
  }
}
