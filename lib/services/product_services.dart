import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:whatsapp/models/product.dart';

class ProductService {
  static Future<Map> getProducts(Page) async {
    final response =
        await http.get('http://roocket.org/api/products?page=${Page}');
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body)['data'];
      List<Product> products = [];
      responseBody['data'].forEach((item) {
        products.add(Product.fromJson(item));
      });
      return {
        "current_page": responseBody['current_page'],
        "products": products
      };
    }
  }
}
