import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iec_app/app/modules/product/data/models/get_all_product_model.dart';
import 'package:iec_app/core/environment/apiUrl.dart';

class ProductsService {
  Future<List<dynamic>> getAllProducts() async {
    Map<String, String> headers = {
      // HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json',
      "Accept": "application/json",
    };
    // Map<String, String> body = {
    //   "accountNo": accountNumber,
    //   "bankName": bankName,
    //   "accountName": accountName,
    // };
    final response = await http.get(
      Uri.parse(ApiUrl.getAppProductsUrl),
      headers: headers,
      // body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      print(response.body);
      return jsonResponse;
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to get all products');
    }
  }
}
