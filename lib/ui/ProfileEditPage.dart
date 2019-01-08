import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
                autofocus: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your name',
                    labelText: 'Name:')),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your name',
                    labelText: 'Phone:')),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please, type your date of birth',
                    labelText: 'Date of Birth:')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: const Text('Save'),
                  onPressed: (){
                    //TODO: Implement save profile
                  },
                ),
                RaisedButton(
                  child: const Text('Delete'),
                  onPressed: (){
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
