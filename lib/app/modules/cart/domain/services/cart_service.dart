import 'dart:convert';

import 'package:iec_app/core/environment/apiUrl.dart';
import 'package:http/http.dart' as http;

class CartService {
  static Future addToCart() async {
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
        "{'userId':5,'date':2020-02-03,'products':[{productId:9,quantity:1},{productId:2,quantity:5}]}";
    final response = await http.post(
      Uri.parse(ApiUrl.addToCartUrl),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(response.statusCode);
      return jsonResponse;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to add to cart');
    }
  }

  Future<Map<String, dynamic>> getCart({required String userId}) async {
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
    String baseUrl = ApiUrl.baseUrl;
    final response = await http.get(
      Uri.parse('$baseUrl/carts/$userId'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print(response.statusCode);
      return jsonResponse;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to get cart');
    }
  }
}
