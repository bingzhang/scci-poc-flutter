/*
 * Copyright (c) 2019 UIUC. All rights reserved.
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

  Future<void> loadUser() async {
    final String userUuid = await AppUtils.getUserUuid();
    _user = await ServerRequest.fetchUser(userUuid);
  }

  Future<bool> saveUser(User user) async {
    bool success = await ServerRequest.saveUser(user);
    if (success) {
      _user = user;
    }
    return success;
  }

  Future<bool> deleteUser(String userUuid) async {
    bool success = await ServerRequest.deleteUser(userUuid);
    if (success) {
      _user = null;
    }
    return success;
  }

  ProfileLogic._internal();
}
