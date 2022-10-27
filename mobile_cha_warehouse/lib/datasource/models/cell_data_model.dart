import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';

class CellDataModel extends Cell {
  String? shelfId;
  int? rowId;
  int? id;
  // int? capacity;
  // List<ContainerData>? containers;
  CellDataModel(
      this.shelfId, this.rowId, this.id, )
      : super(
            shelfId: shelfId,
            rowId: rowId,
            id: id,
           );

  factory CellDataModel.fromJson(Map<String, dynamic> json) {
    return CellDataModel(
        json["shelfId"],
        json["row"],
        json["column"],
        // json["capacity"],
        // json["container"] == null
        //     ? null
        //     : (json["slices"] as List)
        //         .map((e) => ContainerModel.fromJson(e))
        //         .toList()
        );
  }
}

