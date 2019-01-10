
class Person {
  String uuid;
  String name;
  String phone;
  String birthDate;

  Person({this.uuid, this.name, this.phone, this.birthDate});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      uuid: json['uuid'],
      name: json['name'],
      phone: json['phone'],
      birthDate: json['birth_date'],
    );
  }
}