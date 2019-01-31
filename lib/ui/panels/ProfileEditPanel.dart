/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/logic/ProfileLogic.dart';
import 'package:profile_demo/utility/Utils.dart';
import 'package:profile_demo/ui/Alert.dart';

class ProfileEditPanel extends StatefulWidget {
  ProfileEditPanel({Key key}) : super(key: key);

  @override
  _ProfileEditPanelState createState() => _ProfileEditPanelState();
}

class _ProfileEditPanelState extends State<ProfileEditPanel> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _loading = false;
  String _userName;
  String _userPhone;
  String _userBirthDate;
  Role _userRole = Role.unknown;

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
    final User user = ProfileLogic().getUser();
    setState(() {
      final bool hasUser = (user != null);
      _nameController.text = (hasUser) ? user.name : null;
      _phoneController.text = (hasUser) ? user.phone : null;
      _birthDateController.text = (hasUser) ? user.birthDate : null;
      _userRole = (hasUser) ? user.role : Role.unknown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Profile'),
        ),
        body: ModalProgressHUD(
            child: _buildEditProfileContainer(context), inAsyncCall: _loading));
  }

  Widget _buildEditProfileContainer(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: _buildProfileInfoForm(),
        ),
      ),
    );
  }

  Widget _buildProfileInfoForm() {
    return Column(
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
                    children: <Widget>[Text('Role:')])),
            RadioListTile(
                title: Text('Student'),
                value: Role.student,
                groupValue: _userRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: Text('Staff'),
                value: Role.staff,
                groupValue: _userRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: Text('Other'),
                value: Role.other,
                groupValue: _userRole,
                onChanged: _onRoleChanged)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              color: UiConstants.buttonDefaultBackColor,
              child: Text(
                'Save',
                style: UiConstants.buttonDefaultTextStyle,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  setLoading(true);
                  _formKey.currentState.setState(() {
                    _userName = _nameController.text;
                    _userPhone = _phoneController.text;
                    _userBirthDate = _birthDateController.text;
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
              color: UiConstants.buttonDefaultBackColor,
              child: Text(
                'Delete',
                style: UiConstants.buttonDefaultTextStyle,
              ),
              onPressed: () {
                setLoading(true);
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
    final String userUuid = await AppUtils.getUserUuid();
    final User updatedUser = User(
        uuid: userUuid,
        name: _userName,
        phone: _userPhone,
        birthDate: _userBirthDate,
        role: _userRole);
    ProfileLogic().saveUser(updatedUser).then((saveSucceeded) {
      setLoading(false);
      String saveResultMsg =
          (saveSucceeded ? "Succeeded" : "Failed") + " to save user profile";
      Alert.showDialogResult(context, saveResultMsg).then((alertDismissed) {
        if (saveSucceeded && (true == alertDismissed)) {
          Navigator.pop(context);
        }
      });
    });
  }

  void _performDelete() async {
    final String userUuid = await AppUtils.getUserUuid();
    if (userUuid == null) {
      Alert.showDialogResult(context, 'There is no saved profile to delete.');
      return;
    }
    ProfileLogic().deleteUser(userUuid).then((deleteSucceeded) {
      setLoading(false);
      String deleteResultMsg = (deleteSucceeded ? 'Succeeded' : 'Failed') +
          ' to delete user profile';
      Alert.showDialogResult(context, deleteResultMsg).then((alertDismissed) {
        if (deleteSucceeded) {
          _restoreUserValues();
        }
      });
    });
  }

  void _restoreUserValues() {
    setState(() {
      _nameController.clear();
      _phoneController.clear();
      _birthDateController.clear();
      _userRole = Role.unknown;
    });
  }

  void _onRoleChanged(Role role) {
    setState(() {
      _userRole = role;
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
    return _userRole != Role.unknown;
  }

  void setLoading(bool isLoading) {
    setState(() {
      _loading = isLoading;
    });
  }
}
