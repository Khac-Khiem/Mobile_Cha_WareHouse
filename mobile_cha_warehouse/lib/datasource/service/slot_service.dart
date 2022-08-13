import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/cell_data_model.dart';

class SlotService {
  Future<CellDataModel> getCellById(String id) async {
    final res = await http.get(Uri.parse(
        'https://cha-warehouse-management.azurewebsites.net/api/shelves/cells?containerId=$id&='));
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
    //  print(body);
      CellDataModel cell = CellDataModel.fromJson(body);

      return cell;
    } else {
      print(res.statusCode);
      throw "Unable to retrieve posts.";
    }
  }
}
