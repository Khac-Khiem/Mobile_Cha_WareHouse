import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/token_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/global.dart';

class LoginService {
  Future<WarehouseEmployeeModel> login() async {
    final res = await http.get(Uri.parse(''));
    if (res.statusCode == 200) {
      WarehouseEmployeeModel body = jsonDecode(res.body);
      // List<GoodsIssueModel> stations = body
      //     .map(
      //       (dynamic item) => StationModel.fromJson(item),
      //     )
      //     .toList();
      WarehouseEmployee employee = body;
      employeeIdOverall = employee.employeeId;
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
