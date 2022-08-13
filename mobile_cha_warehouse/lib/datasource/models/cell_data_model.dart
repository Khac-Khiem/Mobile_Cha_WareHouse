import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

class CellDataModel extends Cell {
  String? shelfId;
  int? rowId;
  int? id;
  int? capacity;
  List<ContainerData>? containers;
  CellDataModel(
      this.shelfId, this.rowId, this.id, this.capacity, this.containers)
      : super(
            shelfId: shelfId,
            rowId: rowId,
            id: id,
            capacity: capacity,
            containers: containers);

  factory CellDataModel.fromJson(Map<String, dynamic> json) {
    return CellDataModel(
        json["shelfId"],
        json["rowId"],
        json["id"],
        json["capacity"],
        json["container"] == null
            ? null
            : (json["slices"] as List)
                .map((e) => ContainerModel.fromJson(e))
                .toList());
  }
}
