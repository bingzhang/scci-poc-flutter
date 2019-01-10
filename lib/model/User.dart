
class User {
  String uuid;
  String name;
  String phone;
  String birthDate;

  User({this.uuid, this.name, this.phone, this.birthDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      name: json['name'],
      phone: json['phone'],
      birthDate: json['birth_date'],
    );
  }
}