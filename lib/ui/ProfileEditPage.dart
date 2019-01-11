import 'package:flutter/material.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/Alert.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

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
      body: new SingleChildScrollView(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: profileInfoForm(),
          ),
        ),
      ),
    );
  }
  Widget profileInfoForm() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            validator: validateName,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please, type your name',
                labelText: 'Name:')),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: validateMobile,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please, type your name',
                labelText: 'Phone:')),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
            controller: _birthDateController,
            keyboardType: TextInputType.datetime,
            validator: validateBirthDate,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please, type your date of birth',
                labelText: 'Date of Birth:')),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              child: const Text('Save'),
              onPressed: () {
                  if(_formKey.currentState.validate()) {
                    _formKey.currentState.setState(() {
                      _user.name = _nameController.text;
                      _user.phone = _phoneController.text;
                      _user.birthDate = _birthDateController.text;
                    });
                    performSave();
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
              },
            ),
            RaisedButton(
              child: const Text('Delete'),
              onPressed: () {
                performDelete();
              },
            ),
          ],
        )
      ],
    );
  }

  void performSave() async {
    bool saveSucceeded = await ServerRequest.saveUser(_user);
    String saveResultMsg =
        (saveSucceeded ? "Succeeded" : "Failed") + " to save user profile";
    Alert.showDialogResult(context, saveResultMsg);
  }

  void performDelete() async {
    bool deleteSucceeded = await ServerRequest.deleteUser(_user.uuid);
    String deleteResultMsg =
        (deleteSucceeded ? "Succeeded" : "Failed") + " to delete user profile";
    Alert.showDialogResult(context, deleteResultMsg);
    restoreTextFields(deleteSucceeded);
  }

  void restoreTextFields(bool restore) {
    if (restore) {
      setState(() {
        _nameController.clear();
        _phoneController.clear();
        _birthDateController.clear();
      });
    }
  }
  
  //Validations
  String validateMobile(String mobile) {
    RegExp regExp = new RegExp('[0-9]{11}');
    if (regExp.hasMatch(mobile))
      return 'Mobile Number can be 10 digits maximum';
    else
      return null;
  }

  String validateName(String name) {
    RegExp regExp = new RegExp(r'^[A-Za-z ]+$');
    if (!regExp.hasMatch(name))
      return 'Please enter only alphabetical characters.';
    else
      return null;
  }

  String validateBirthDate(String date) {
    //TODO propper regex
    RegExp regExp = new RegExp("[a-zA-Z]");
    if (!regExp.hasMatch(date))
      return 'Birht date should be in format: yyyy/MM/dd';
    else
      return null;
  }
}
