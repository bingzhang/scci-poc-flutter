import 'package:flutter/material.dart';
import 'package:profile_demo/ui/ProfileEditPage.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/Alert.dart';

class ProfileHomePage extends StatefulWidget {
  ProfileHomePage({Key key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  final _hostController = TextEditingController();

  @override
  void dispose() {
    _hostController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadHost();
  }

  void loadHost() async {
    final String serverHost = await Utils.getHostAddress();
    setState(() {
      _hostController.text = serverHost;
    });
  }

  void performSaveHostAddress(String hostAddress) async {
    Utils.saveHostAddress(hostAddress);
    Alert.showDialogResult(context, 'Host addres $hostAddress saved');

  }

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ProfileHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Profile Demo"),
      ),
      body: ListView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                      controller: _hostController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Please, type your host',
                          labelText: 'Host:')),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: RaisedButton(
                    child: const Text('Save'),
                    onPressed: () => performSaveHostAddress(_hostController.text),
                  ),
                ),
              ],
            ),
          ),
          Center(
            heightFactor: 10,
            child: RaisedButton(
              child: const Text('Profile'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage())),
            ),
          )
        ],
      ),
    );
  }
}