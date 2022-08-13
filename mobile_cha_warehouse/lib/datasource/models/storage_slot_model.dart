import 'package:mobile_cha_warehouse/datasource/models/cell_data_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';


class ShelfModel extends Shelf {
  ShelfModel(String shelfId, List<Cell> cells, int priority)
      : super(shelfId, cells, priority);
  factory ShelfModel.fromJson(Map<String, dynamic> json) {
    return ShelfModel(
      json["shelfId"],
      json["cells"] == null
          ? []
          : (json["cells"] as List)
              .map((e) => CellDataModel.fromJson(e))
              .toList(),
      json["priority"],
    );
  }
}
