import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iec_app/core/environment/apiUrl.dart';

class AuthService {
  static Future addNewUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String userName,
      required String password,
      required String address,
      required String phoneNumber}) async {
    Map<String, String> headers = {
      // HttpHeaders.authorizationHeader: 'Bearer $userToken',
      // 'Content-Type': 'application/json',
      "Accept": "application/json",
    };
    Map<String, dynamic> body = {
      'email': email,
      'username': userName,
      'password': password,
      'name': {'firstname': firstName, 'lastname': lastName},
      address: {
        'city': address,
        'street': address,
        'number': 3,
        'zipcode': '',
        'geolocation': {'lat': '-37.3159', 'long': '81.1496'}
      },
      'phone': phoneNumber
    };
    final response = await http.post(
      Uri.parse(ApiUrl.addUserUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to add users');
    }
  }

  static Future loginUser({
    required String userName,
    required String password,
  }) async {
    Map<String, String> headers = {
      // HttpHeaders.authorizationHeader: 'Bearer $userToken',
      // 'Content-Type': 'application/json',
      "Accept": "application/json",
    };

    Map<String, dynamic> body = {
      'username': userName,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(ApiUrl.addUserUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to log in');
    }
  }
}
