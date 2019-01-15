import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/ui/ProfileEditPage.dart';

class ProfileHomePage extends StatefulWidget {
  ProfileHomePage({Key key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> with RouteAware {
  Role _userRole;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadUser() async {
    final String userUuid = await Utils.getUserUuid();
    final User user = await ServerRequest.fetchUser(userUuid);
    setState(() {
      _userRole = (user != null) ? user.role : Role.unknown;
    });
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
              visible: _userRole == Role.student,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Directions'), onPressed: null),
                    RaisedButton(
                        child: const Text('Information'), onPressed: null)
                  ])),
          Visibility(
              visible: _userRole == Role.staff,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Factulty Listing'), onPressed: null),
                    RaisedButton(child: const Text('Schedule'), onPressed: null)
                  ])),
          Visibility(
              visible: _userRole == Role.other,
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
