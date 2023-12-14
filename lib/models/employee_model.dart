
class EmployeeModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;

  EmployeeModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['avatar'] = avatar;

    return data;
  }
}



