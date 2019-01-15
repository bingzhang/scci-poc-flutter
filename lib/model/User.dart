import 'package:profile_demo/model/Role.dart';
import 'package:profile_demo/utility/Utils.dart';

class User {
  String uuid;
  String name;
  String phone;
  String birthDate;
  Role role;

  User({this.uuid, this.name, this.phone, this.birthDate, this.role});

  User.fromUuid(String uuid) {
    this.uuid = uuid;
  }

  toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'phone': phone,
      'birth_date': birthDate,
      'role': _userRoleToString(role)
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uuid: json['uuid'],
        name: json['name'],
        phone: json['phone'],
        birthDate: json['birth_date'],
        role: _userRoleFromString(json['role']));
  }

  static Role _userRoleFromString(String roleString) {
    if (Utils.isStringEmpty(roleString)) {
      return Role.unknown;
    }
    return Role.values.firstWhere((role) => _userRoleToString(role) == roleString);
  }

  static String _userRoleToString(Role role) {
    if (role == null) {
      return _userRoleToString(Role.unknown);
    }
    String roleToString = role.toString();
    const int subStringStartIndex = 'Role.'.length; //remove enum class from toString method
    return roleToString
        .substring(subStringStartIndex);
  }
}
