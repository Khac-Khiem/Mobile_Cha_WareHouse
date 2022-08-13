import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';

// class StockCardEntryModel extends StockCardEntry {
//   StockCardEntryModel(String date, double beforeQuantity, double inputQUantity,
//       double outputQuantity, double afterQuantity, String note)
//       : super(date, beforeQuantity, inputQUantity, outputQuantity,
//             afterQuantity, note);
//   factory StockCardEntryModel.fromJson(Map<String, dynamic> json) {
//     return StockCardEntryModel(
//       json["date"],
//       double.parse(json["beforeQuantity"].toString()),
//       double.parse(json["inputQuantity"].toString()),
//       double.parse(json["outputQuantity"].toString()),
//       double.parse(json["afterQuantity"].toString()),
//       json["note"],
//     );
//   }
// }
class StockCardEntryModel extends StockCardEntry {
  StockCardEntryModel(
      int itemId,
      Item item,
      DateTime date,
      double beforeQuantity,
      double inputQUantity,
      double outputQuantity,
      double afterQuantity,
      String note)
      : super(itemId, item, date, beforeQuantity, inputQUantity, outputQuantity,
            afterQuantity, note);
  factory StockCardEntryModel.fromJson(Map<String, dynamic> json) {
    return StockCardEntryModel(
      json["itemId"],
      json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
      json["date"],
      double.parse(json["beforeQuantity"].toString()),
      double.parse(json["inputQuantity"].toString()),
      double.parse(json["outputQuantity"].toString()),
      double.parse(json["afterQuantity"].toString()),
      json["note"],
    );
  }
}

class StockCardModel extends StockCard {
  StockCardModel(List<StockCardEntryModel> items) : super(items);
}
