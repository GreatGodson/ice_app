import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iec_app/core/environment/apiUrl.dart';

class CategoryProductsService {
  Future<List<dynamic>> getAllCategoryProducts(
      {required String categoryName}) async {
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
    const baseUrl = ApiUrl.baseUrl;
    final getCategoryProductUrl = '$baseUrl/products/category/$categoryName';
    final response = await http.get(
      Uri.parse(getCategoryProductUrl),
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
      throw Exception('Failed to get all products in this category');
    }
  }
}
