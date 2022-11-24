import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel(
    String id,
    String name,
    dynamic piecesPerKilogram,
    dynamic lifeCycle,
    // var minimumStockLevel,
    // var maximumStockLevel,
    int unit,
    // WarehouseEmployeeModel manager
    dynamic manager,
    bool hasManyUnits,
  ) : super(id, name, piecesPerKilogram, lifeCycle, unit, manager,
            hasManyUnits);

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      json["itemId"],
      json["name"],
      json["piecesPerKilogram"],
      json["lifeCycle"],
      // json["minimumStockLevel"],
      // json["maximumStockLevel"],
      json["unit"],
      json["manager"] == null
          ? null
          : WarehouseEmployeeModel.fromJson(json["manager"]),
      //WarehouseEmployeeModel('', '', '', DateTime.now())
      json["hasManyUnits"],
    );
  }
}
