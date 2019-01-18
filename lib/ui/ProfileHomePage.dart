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
          RoundedImageButton(
              visible: (_userRole != Role.unknown),
              imageRelativePath: 'images/campus.jpg',
              onTapGesture: () {
                _openWeb("Getting Around", "https://goo.gl/maps/vc7DRLgiMM22");
              }),
          RoundedImageButton(
              visible: (_userRole == Role.student),
              imageRelativePath: 'images/Bardeen-Quad2.jpg',
              onTapGesture: () {
                _openWeb("General Info",
                    "http://catalog.illinois.edu/general-information/");
              }),
          RoundedImageButton(
              visible: (_userRole != Role.unknown),
              imageRelativePath: 'images/athletics.jpg',
              onTapGesture: () {
                _openWeb("Athletics", "https://fightingillini.com/");
              }),
          RoundedImageButton(
              visible:
                  ((_userRole == Role.student) || (_userRole == Role.staff)),
              imageRelativePath: 'images/krannert.jpg',
              onTapGesture: () {
                _openWeb("Events", "https://krannertcenter.com/calendar");
              }),
          RoundedImageButton(
              visible: (_userRole == Role.student),
              imageRelativePath: 'images/Altgeld.jpg',
              onTapGesture: () {
                _openWeb("Schedule",
                    "https://courses.illinois.edu/schedule/DEFAULT/DEFAULT");
              }),
          RoundedImageButton(
            visible: true,
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
