import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/ui/ProfileEditPage.dart';
import 'package:profile_demo/ui/WebContentPage.dart';
import 'package:profile_demo/ui/widgets/RoundedImageButton.dart';

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
    final String userUuid = await AppUtils.getUserUuid();
    final User user = await ServerRequest.fetchUser(userUuid);
    setState(() {
      _userRole = (user != null) ? user.role : Role.unknown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset(
          'images/illinois_vertical.png',
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
        ),
        centerTitle: true,
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
                        color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                        child: const Text(
                          'Directions',
                          style: UiConstants.BUTTON_DEFAULT_TEXT_STYLE,
                        ),
                        onPressed: () {
                          _openWeb(
                              "Directions", "https://goo.gl/maps/vc7DRLgiMM22");
                        }),
                    RaisedButton(
                        color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                        child: const Text(
                          'Information',
                          style: UiConstants.BUTTON_DEFAULT_TEXT_STYLE,
                        ),
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
                        color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                        child: const Text(
                          'Faculty Listing',
                          style: UiConstants.BUTTON_DEFAULT_TEXT_STYLE,
                        ),
                        onPressed: () {
                          _openWeb("Faculty Listing",
                              "https://directory.illinois.edu/facultyListing");
                        }),
                    RaisedButton(
                        color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                        child: const Text(
                          'Schedule',
                          style: UiConstants.BUTTON_DEFAULT_TEXT_STYLE,
                        ),
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
                        color: UiConstants.BUTTON_DEFAULT_BACK_COLOR,
                        child: const Text(
                          'Directions',
                          style: UiConstants.BUTTON_DEFAULT_TEXT_STYLE,
                        ),
                        onPressed: () {
                          _openWeb(
                              "Directions", "https://goo.gl/maps/vc7DRLgiMM22");
                        })
                  ])),
          RoundedImageButton(
            imageRelativePath: 'images/Illinois.jpg',
            onTapGesture: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileEditPage()))
                .then((value) => _loadUser()),
          ),
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
