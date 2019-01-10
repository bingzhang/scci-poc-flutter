import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/utility/Utils.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  User _user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void loadUser() async {
    final String userUuid = await Utils.getUserUuid();
    _user = await ServerRequest.fetchUser(userUuid);
    if (_user == null) {
      _user = new User.fromUuid(userUuid);
    }
    setState(() {
      _nameController.text = _user.name;
      _phoneController.text = _user.phone;
      _birthDateController.text = _user.birthDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your name',
                    labelText: 'Name:')),
            TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your name',
                    labelText: 'Phone:')),
            TextField(
                controller: _birthDateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your date of birth',
                    labelText: 'Date of Birth:')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: const Text('Save'),
                  onPressed: () {
                    setState(() {
                      _user.name = _nameController.text;
                      _user.phone = _phoneController.text;
                      _user.birthDate = _birthDateController.text;
                    });
                    handleSaveResult();
                  },
                ),
                RaisedButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    //TODO: Implement delete profile
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void handleSaveResult() async {
    bool succeeded = await ServerRequest.saveUser(_user);
    String saveResultMsg = (succeeded ? "Suceeded" : "Failed") + " to save user profile";
    showDialogResult(saveResultMsg);
  }

  void showDialogResult(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
