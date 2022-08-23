import 'dart:convert';

import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/production_employee_model.dart';
import 'package:http/http.dart' as http;


class ProductionService {
  Future<List<ProductionEmployeeModel>> getAllEmployees() async {
    final res = await http.get(Uri.parse(Constants.baseUrl+
        'api/productionemployees/') );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      print(body.toString());
      List<ProductionEmployeeModel> employees = body
          .map(
            (dynamic item) => ProductionEmployeeModel.fromJson(item),
          )
          .toList();
      print(employees.toString());
      return employees;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
