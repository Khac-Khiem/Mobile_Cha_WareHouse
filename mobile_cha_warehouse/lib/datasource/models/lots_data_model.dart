import 'package:mobile_cha_warehouse/datasource/models/cell_data_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';

class LotsModel extends Lots{
  LotsModel(String lotId, Cell? cell, int quantity, String date, Item? item) : super(lotId, cell, quantity, date, item);
  factory LotsModel.fromJson(Map<String, dynamic> json) {
    return LotsModel(
      json["lotId"],
      json["cell"] == null
          ? null
          : CellDataModel.fromJson(json["cell"]),
      json["quantity"],
      json["date"],
      json["item"] == null ? null : ItemModel.fromJson(json["item"]), 
    );
  }
}