import 'package:mobile_cha_warehouse/datasource/models/cell_data_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/production_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

import '../../domain/entities/cell_data.dart';

class ContainerTypeModel extends ContainerType {
  ContainerTypeModel(String name, int weight) : super(name, weight);
  factory ContainerTypeModel.fromJson(Map<String, dynamic> json) {
    return ContainerTypeModel(
      json["name"],
      json["weight"],
    );
  }
}

class ContainerModel extends ContainerData {
  ContainerModel(
      String containerId,
      int quantity,
      String productionDate,
      bool isNotEmpty,
      Item item,
    //  ProductionEmployee productionEmployee,
      Cell location,
      ContainerType containerType)
      : super(containerId, quantity, productionDate, isNotEmpty, item, location,
             containerType);
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      json["containerId"],
      json["quantity"],
      json["productionDate"],
      json["consistent"],
      json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
      // json["productionEmployee"] == null
      //     ? null!
      //     : ProductionEmployeeModel.fromJson(json["productionEmployee"]),
      json["location"] == null
          ? null!
          : CellDataModel.fromJson(json["location"]),
      json["containerType"] == null
          ? null!
          : ContainerTypeModel.fromJson(json["containerType"]),
    );
  }
}
