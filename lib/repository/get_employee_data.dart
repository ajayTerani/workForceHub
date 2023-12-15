import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/employee_model.dart';

class GetEmployeeData {
  Future<List<EmployeeModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> employeeData = data['data'];

      return employeeData.map((item) => EmployeeModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
