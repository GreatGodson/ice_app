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
    // Map<String, String> body = {
    //   "email": email,
    //   "firstname": firstName,
    //   "lastname": lastName,
    //   "username": userName,
    //   "password": password,
    //   "address": address,
    //   "phone": phoneNumber
    // };

    String body =
        '{"address":{"geolocation":{"lat":"40.12456","long":"20.5419"},"city":"miami","street":"avondale ave","number":345,"zipcode":"96378-0245"},"id":9,"email":"kate@gmail.com","username":"kate_h","password":"kfejk@*_","name":{"firstname":"kate","lastname":"hale"},"phone":"1-678-456-1934","__v":0}';

    Map<String, dynamic> bodyVal = {
      'email': 'John@gmail.com',
      'username': 'johnd',
      'password': 'm38rmF＄',
      'name': {'firstname': 'John', 'lastname': 'Doe'},
      address: {
        'city': 'kilcoole',
        'street': '7835 new road',
        'number': 3,
        'zipcode': '12926-3874',
        'geolocation': {'lat': '-37.3159', 'long': '81.1496'}
      },
      'phone': '1-570-236-7033'
    };
    final response = await http.post(
      Uri.parse(ApiUrl.addUserUrl),
      headers: headers,
      body: bodyVal,
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
    // Map<String, String> body = {
    //   "email": email,
    //   "firstname": firstName,
    //   "lastname": lastName,
    //   "username": userName,
    //   "password": password,
    //   "address": address,
    //   "phone": phoneNumber
    // };

    String body = "{ 'username': 'kate_h','password': 'kfejk@*_'}";
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
