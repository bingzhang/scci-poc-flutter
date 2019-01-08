import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
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
                autofocus: true,
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
                    return showDialog(
                      context: context,
                      builder: (context) {
                        var name = _nameController.text;
                        var phone = _phoneController.text;
                        var birthDate = _birthDateController.text;
                        return AlertDialog(
                          // Retrieve the text the user has typed in using our
                          // TextEditingController
                          content: Text('Name: $name\nPhone: $phone\nBirthdate: $birthDate'),
                        );
                      },
                    );
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
}
