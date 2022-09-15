import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';

class LoginService {
  Future<String> login(String userName, String password) async {
    final url = Uri.parse(
        'https://chaauthenticationdelegateservice.azurewebsites.net/api/login');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(<String, String>{
          "username": userName,
          "password": password,
        }));
    //  final res = await http.post(Uri.parse('https://chaauthenticationdelegateservice.azurewebsites.net/api/login'));
    if (response.statusCode == 200) {
      token = response.body;
      return response.body;
    } else {
      return 'error';
      // throw "Unable to retrieve posts.";
    }
  }
}
