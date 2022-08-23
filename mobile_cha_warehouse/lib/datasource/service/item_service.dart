import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';

import '../../constant.dart';

class ItemService {
  Future<List<ItemModel>> getAllItems() async {
    final res = await http.get(Uri.parse(Constants.baseUrl+
        'api/items/') );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      print(body.toString());
      List<ItemModel> items = body
          .map(
            (dynamic item) => ItemModel.fromJson(item),
          )
          .toList();
      print(items.toString());
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
