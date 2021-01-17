import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 class AuthService{
   Future<Map> sendDataToLogin(Map body) async{
    final response = await http.post('http://roocket.org/api/login' , body: body);
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  static Future<bool> checkApiToken(String apiToken) async{
    final response = await http.get('http://roocket.org/api/user?api_token=${apiToken}', headers: {'Accept': 'application/json'});
    return response.statusCode== 200;
  }
}