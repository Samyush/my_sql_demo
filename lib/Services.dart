import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Employee.dart';

class Services {
  static const ROOT =
      'http://192.168.31.54/dashboard/EmpDB/employee_action.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

//  method to create the table Employees

  static Future<String> createTable() async {
    try {
//add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('create Table Response: ${response.body}');
      print(response.statusCode);

      if (200 == response.statusCode) {
//        print("success");

        return response.body;
      } else {
//        print("error");
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      //add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('get Employees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        return List<Employee>(); //return any empty list on exception
      }
    } catch (e) {
      return List<Employee>(); //return any empty list on exception
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

//  method to add Employee

  static Future<String> addEmployees(String firstName, String lastName) async {
    try {
      //add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;

      final response = await http.post(ROOT, body: map);
      print('add Employees Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

//method to update an Employee in Database
  static Future<String> updateEmployee(
      int empId, String firstName, String lastName) async {
    try {
      //add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;

      final response = await http.post(ROOT, body: map);
      print('update Employees Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// TO DELETE
//method to update an Employee in Database
  static Future<String> deleteEmployee(int empId) async {
    try {
      //add the parameters to pass the request
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;

      final response = await http.post(ROOT, body: map);
      print('delete Employees Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
