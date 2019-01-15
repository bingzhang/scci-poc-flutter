import 'package:flutter/material.dart';
import 'package:profile_demo/ui/ProfileEditPage.dart';

class ProfileHomePage extends StatefulWidget {
  ProfileHomePage({Key key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Demo"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
              visible: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Directions'), onPressed: null),
                    RaisedButton(
                        child: const Text('Information'), onPressed: null)
                  ])),
          Visibility(
              visible: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Factulty Listing'), onPressed: null),
                    RaisedButton(child: const Text('Schedule'), onPressed: null)
                  ])),
          Visibility(
              visible: true,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Directions'), onPressed: null)
                  ])),
          RaisedButton(
            child: const Text('Profile'),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileEditPage())),
          )
        ],
      )),
    );
  }
}
