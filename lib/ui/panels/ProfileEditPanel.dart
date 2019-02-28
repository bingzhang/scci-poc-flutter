/*
 * Copyright (c) 2019 UIUC. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:profile_demo/lang/locale/locales.dart';
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
    final AppLocalizations str = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              str.profileEditTitle /*, style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold)*/),
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
    final AppLocalizations str = AppLocalizations.of(context);
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
                  hintText: str.profileEditNameHint,
                  labelText: str.profileEditNameLabel)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.text,
              validator: _validateMobile,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: str.profileEditPhoneHint,
                  labelText: str.profileEditPhoneLabel)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
              controller: _birthDateController,
              keyboardType: TextInputType.text,
              validator: _validateBirthDate,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: str.profileEditBirthDateHint,
                  labelText: str.profileEditBirthDateLabel)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[Text(str.profileEditRoleLabel)])),
            RadioListTile(
                title: Text(str.profileEditRoleStudent),
                value: Role.student,
                groupValue: _userRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: Text(str.profileEditRoleStaff),
                value: Role.staff,
                groupValue: _userRole,
                onChanged: _onRoleChanged),
            RadioListTile(
                title: Text(str.profileEditRoleOther),
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
                str.profileEditButtonSave,
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
                str.profileEditButtonDelete,
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
      Alert.showDialogResult(context, AppLocalizations.of(context).profileEditRoleValidation);
      setLoading(false);
      return;
    }
    String userUuid = ProfileLogic().getUserUuid();
    if (AppUtils.isStringEmpty(userUuid)) {
      userUuid = AppUtils.generateUserUuid();
    }
    final User updatedUser = User(
        uuid: userUuid,
        name: _userName,
        phone: _userPhone,
        birthDate: _userBirthDate,
        role: _userRole);
    ProfileLogic().saveUser(updatedUser).then((saveSucceeded) {
      AppLocalizations str = AppLocalizations.of(context);
      setLoading(false);
      String saveResultMsg =
          (saveSucceeded ? str.stateSucceeded : str.stateFailed) +str.profileEditStateSaveMessage;
      Alert.showDialogResult(context, saveResultMsg).then((alertDismissed) {
        if (saveSucceeded && (true == alertDismissed)) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }
      });
    });
  }

  void _performDelete() async {
    AppLocalizations str = AppLocalizations.of(context);
    User user = ProfileLogic().getUser();
    if (user == null) {
      Alert.showDialogResult(context, str.profileEditStateDeleteError);
      setLoading(false);
      return;
    }
    ProfileLogic().deleteUser().then((deleteSucceeded) {
      setLoading(false);
      String deleteResultMsg = (deleteSucceeded ? str.stateSucceeded : str.stateFailed) +
          str.profileEditStateDeleteMessage;
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
      return AppLocalizations.of(context).profileEditPhoneValidation;
    else
      return null;
  }

  String _validateName(String name) {
    RegExp regExp = new RegExp("[a-zA-Z]+ [a-zA-Z]+");
    if (!regExp.hasMatch(name))
      return AppLocalizations.of(context).profileEditNameValidation;
    else
      return null;
  }

  String _validateBirthDate(String date) {
    String validationErr =
        AppLocalizations.of(context).profileEditBirthDateValidation;
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
