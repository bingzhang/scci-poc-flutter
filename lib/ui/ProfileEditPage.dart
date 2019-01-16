import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
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
  Role _selectedUserRole = Role.unknown;

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
      _selectedUserRole = _user.role;
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
            child: _profileInfoForm(),
          ),
        ),
      ),
    );
  }

  Widget _profileInfoForm() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: _validateName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please, type your name',
                  labelText: 'Name:')),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.text,
              validator: _validateMobile,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please, type your phone number',
                  labelText: 'Phone:')),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
              controller: _birthDateController,
              keyboardType: TextInputType.text,
              validator: _validateBirthDate,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please, type your date of birth',
                  labelText: 'Date of Birth:')),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[const Text('Role:')])),
            RadioListTile(
                title: const Text('Student'),
                value: Role.student,
                groupValue: _selectedUserRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: const Text('Staff'),
                value: Role.staff,
                groupValue: _selectedUserRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: const Text('Other'),
                value: Role.other,
                groupValue: _selectedUserRole,
                onChanged: _onRoleChanged)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: Constants.BUTTON_DEFAULT_BACK_COLOR,
              child: const Text(
                'Save',
                style: Constants.BUTTON_DEFAULT_TEXT_STYLE,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.setState(() {
                    _user.name = _nameController.text;
                    _user.phone = _phoneController.text;
                    _user.birthDate = _birthDateController.text;
                    _user.role = _selectedUserRole;
                  });
                  _performSave();
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              },
            ),
            RaisedButton(
              color: Constants.BUTTON_DEFAULT_BACK_COLOR,
              child: const Text(
                'Delete',
                style: Constants.BUTTON_DEFAULT_TEXT_STYLE,
              ),
              onPressed: () {
                _performDelete();
              },
            ),
          ],
        )
      ],
    );
  }

  void _performSave() async {
    bool isRoleValid = _validateSelectedUserRole();
    if (!isRoleValid) {
      Alert.showDialogResult(context, 'Please, select role.');
      return;
    }
    bool saveSucceeded = await ServerRequest.saveUser(_user);
    String saveResultMsg =
        (saveSucceeded ? "Succeeded" : "Failed") + " to save user profile";
    Alert.showDialogResult(context, saveResultMsg);
  }

  void _performDelete() async {
    bool deleteSucceeded = await ServerRequest.deleteUser(_user.uuid);
    String deleteResultMsg =
        (deleteSucceeded ? "Succeeded" : "Failed") + " to delete user profile";
    Alert.showDialogResult(context, deleteResultMsg);
    _restoreUserValues(deleteSucceeded);
  }

  void _restoreUserValues(bool restore) {
    if (restore) {
      setState(() {
        _nameController.clear();
        _phoneController.clear();
        _birthDateController.clear();
        _selectedUserRole = Role.unknown;
      });
    }
  }

  void _onRoleChanged(Role role) {
    setState(() {
      _selectedUserRole = role;
    });
  }

  //Validations
  String _validateMobile(String mobile) {
    RegExp regExp = new RegExp(
        r"^(\+?1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$");
    if (!regExp.hasMatch(mobile))
      return 'Please, type valid phone number. Ex: (111) 111-1111';
    else
      return null;
  }

  String _validateName(String name) {
    RegExp regExp = new RegExp("[a-zA-Z]+ [a-zA-Z]+");
    if (!regExp.hasMatch(name))
      return 'Please, type name and family.';
    else
      return null;
  }

  String _validateBirthDate(String date) {
    const String validationErr =
        'Please, type valid date in format: yyyy/MM/dd';
    RegExp dateRegEx =
        new RegExp(r"([12]\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[12]\d|3[01]))$");
    if (!dateRegEx.hasMatch(date)) {
      return validationErr;
    }
    final DateFormat dateFormat = new DateFormat("yyyy/MM/dd");
    DateTime birthDate;
    try {
      birthDate = dateFormat.parse(date);
    } catch (e) {
      print(e.toString());
    }
    if (birthDate == null) {
      return validationErr;
    }
    return null;
  }

  bool _validateSelectedUserRole() {
    return _selectedUserRole != Role.unknown;
  }
}
