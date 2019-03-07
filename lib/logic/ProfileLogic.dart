/*
 * Copyright (c) 2019 Illinois. All rights reserved.
 */

import 'package:profile_demo/model/User.dart';
import 'package:profile_demo/http/ServerRequest.dart';
import 'package:profile_demo/utility/Utils.dart';

class ProfileLogic {
  static final ProfileLogic _logic = new ProfileLogic._internal();
  User _user;

  factory ProfileLogic() {
    return _logic;
  }

  User getUser() {
    return _user;
  }

  String getUserUuid() {
    if (_user == null) {
      return null;
    }
    return _user.uuid;
  }

  Future<void> loadUser() async {
    _user = await AppUtils.getUser();
  }

  Future<bool> saveUser(User user) async {
    bool success = await ServerRequest.saveUser(user);
    if (success) {
      _user = user;
      await AppUtils.saveUser(user);
    }
    return success;
  }

  Future<bool> deleteUser() async {
    if (_user == null) {
      return true;
    }
    bool success = await ServerRequest.deleteUser(_user.uuid);
    if (success) {
      _user = null;
      AppUtils.removeUser();
    }
    return success;
  }

  ProfileLogic._internal();
}
