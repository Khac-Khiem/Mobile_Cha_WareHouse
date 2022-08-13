import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/stockcard_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/token_model.dart';

class StockCardService {
  Future<List<StockCardEntryModel>> getStockCardByItem(
      String itemId, String startDate, String endDate) async {
    final res = await http.get(Uri.parse(
        'https://cha-warehouse-management.azurewebsites.net/api/stockcardentries/?StartTime=$startDate&EndTime=$endDate&ItemId=$itemId'));
    if (res.statusCode == 200) {
      print(res.body);
      List<dynamic> body = jsonDecode(res.body);
      List<StockCardEntryModel> stockcard = body
          .map(
            (dynamic item) => StockCardEntryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
