import 'package:profile_demo/model/Role.dart';

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
      'role': role
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      name: json['name'],
      phone: json['phone'],
      birthDate: json['birth_date'],
      role: json['role']
    );
  }
}