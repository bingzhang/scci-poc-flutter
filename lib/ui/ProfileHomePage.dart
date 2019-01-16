import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/ui/ProfileEditPage.dart';
import 'package:profile_demo/ui/WebContentPage.dart';

class ProfileHomePage extends StatefulWidget {
  ProfileHomePage({Key key}) : super(key: key);

  @override
  _ProfileHomePageState createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
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
        title: Text('Profile Demo'),
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
                        child: const Text('Directions'),
                        onPressed: () {
                          _openWeb(
                              "Directions", "https://goo.gl/maps/vc7DRLgiMM22");
                        }),
                    RaisedButton(
                        child: const Text('Information'),
                        onPressed: () {
                          _openWeb("Information",
                              "http://catalog.illinois.edu/general-information/");
                        })
                  ])),
          Visibility(
              visible: _userRole == Role.staff,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Faculty Listing'),
                        onPressed: () {
                          _openWeb("Faculty Listing",
                              "https://directory.illinois.edu/facultyListing");
                        }),
                    RaisedButton(
                        child: const Text('Schedule'),
                        onPressed: () {
                          _openWeb("Schedule",
                              "https://courses.illinois.edu/schedule/DEFAULT/DEFAULT");
                        })
                  ])),
          Visibility(
              visible: _userRole == Role.other,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: const Text('Directions'),
                        onPressed: () {
                          _openWeb(
                              "Directions", "https://goo.gl/maps/vc7DRLgiMM22");
                        })
                  ])),
          RaisedButton(
              child: const Text('Profile'),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileEditPage()))
                  .then((value) => _loadUser()))
        ],
      )),
    );
  }

  void _openWeb(String title, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new WebContentPage(url: url, title: title)));
  }
}
