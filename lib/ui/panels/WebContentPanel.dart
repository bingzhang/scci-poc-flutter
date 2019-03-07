/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';

import 'package:profile_demo/lang/locale/locales.dart';

enum _OnlineStatus { unknown, checking, online, offline }

class WebContentPanel extends StatefulWidget {
  final String url;
  final String title;

  WebContentPanel({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebContentPanelState createState() => _WebContentPanelState(url, title);
}

class _WebContentPanelState extends State<WebContentPanel> {
  final String url;
  final String title;
  _OnlineStatus _onlineStatus = _OnlineStatus.unknown;
  
  _WebContentPanelState(this.url, this.title) : super();

  @override
  void initState() {
    super.initState();
    checkOnlineStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations str = AppLocalizations.of(context);
    if (_onlineStatus == _OnlineStatus.checking) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(this.title /*, style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold)*/),
        ),
        body: ModalProgressHUD(child: Center(child: Text(str.webPleaseWaith, style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w700, fontSize: 32, color: Colors.black, ),)), inAsyncCall: true));
    }
    else if (_onlineStatus == _OnlineStatus.online) {
      return new WebviewScaffold(
        url: this.url,
        hidden: true,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(this.title),
        ),
      );
    }
    else if (_onlineStatus == _OnlineStatus.offline) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(this.title /*, style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold)*/),
        ),
        body: Center(child: Container(width: 280, child: Text(str.webCheckInternetConnection, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w500, fontSize: 18, color: Colors.black, ),)), ));
    }
    else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(this.title /*, style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold)*/),
        ),
        body: Center(child: Center(child: Text(str.webPleaseWaith, style: TextStyle(fontFamily: 'Avenir', fontWeight:FontWeight.w700, fontSize: 32, color: Colors.black, ),)), ));
    }
    
  }

  void checkOnlineStatus() async {
    setState(() {
      _onlineStatus = _OnlineStatus.checking;
    });
    try {
      Uri uri = Uri.parse(this.url);
      final result = await InternetAddress.lookup(uri.host);
      setState(() {
        _onlineStatus = (result.isNotEmpty && result[0].rawAddress.isNotEmpty) ? _OnlineStatus.online : _OnlineStatus.offline;
      });
    }
    on SocketException catch (_) {
      setState(() {
        _onlineStatus = _OnlineStatus.offline;
      });
    }
  }
}