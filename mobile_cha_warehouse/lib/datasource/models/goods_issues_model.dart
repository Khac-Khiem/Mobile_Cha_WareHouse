import 'package:mobile_cha_warehouse/datasource/models/production_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';

// class GoodsIssueEntryContainerModel extends GoodsIssueEntryContainer {
//   GoodsIssueEntryContainerModel(int quantity, String productionDate,
//       String containerId, bool isTaken)
//       : super(quantity, productionDate, containerId, isTaken);
//   factory GoodsIssueEntryContainerModel.fromJson(Map<String, dynamic> json) {
//     return GoodsIssueEntryContainerModel(
//       json["quantity"],
//       json["productionDate"],
//       json["containerId"],
//       json["isTaken"],
//     );
//   }
// }
// model 1 container entry
class GoodsIssueEntryContainerModel extends GoodsIssueEntryContainer {
  GoodsIssueEntryContainerModel(
    //  int goodsIssueEntryId,
      int quantity,
      String productionDate,
      String containerId,
      ProductionEmployee? productionEmployee)
      : super( quantity, productionDate, containerId,
            productionEmployee);
  factory GoodsIssueEntryContainerModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryContainerModel(
     // json["goodsIssueEntryId"],
      json["quantity"],
      json["productionDate"],
      json["containerId"],
      json["productionEmployee"] == null
          ? null
          : ProductionEmployeeModel.fromJson(json["productionEmployee"]),
    );
  }
}

class GoodsIssueEntryModel extends GoodsIssueEntry {
  GoodsIssueEntryModel(
      int plannedQuantity,
   //   int id,
    //  int itemId,
   //   int goodsIssueId,
      Item item,
   //   WarehouseEmployee employee,
      List<GoodsIssueEntryContainerModel>? container)
      : super(plannedQuantity, item,
            container);
  factory GoodsIssueEntryModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueEntryModel(
        // json["id"],
        // json["goodsIssueId"],
        // json["iemId"],
        json["plannedQuantity"],
        json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
        // json["employee"] == null
        //     ? null!
        //     : WarehouseEmployeeModel.fromJson(json["employee"]),
        json["containers"] == null
            ? []
            : (json["containers"] as List)
                .map((e) => GoodsIssueEntryContainerModel.fromJson(e))
                .toList());
  }
}

class GoodsIssueModel extends GoodsIssue {
  GoodsIssueModel(
      String goodsIssueId,
      String timestamp,
      WarehouseEmployeeModel employee,
      bool isConfirmed,
      List<GoodsIssueEntryModel> entries)
      : super(goodsIssueId, timestamp, employee, isConfirmed, entries);
  factory GoodsIssueModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueModel(
      json["goodsIssueId"],
      json["timestamp"],
      json["employee"] == null
          ? null!
          : WarehouseEmployeeModel.fromJson(json["employee"]),
      json["isConfirmed"],
      json["entries"] == null
          ? []
          : (json["entries"] as List)
              .map((e) => GoodsIssueEntryModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsIssueDataModel extends GoodsIssueData {
  GoodsIssueDataModel(List<GoodsIssue> items, int total) : super(items, total);
  factory GoodsIssueDataModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueDataModel(
      json["items"] == null
          ? []
          : (json["items"] as List)
              .map((e) => GoodsIssueModel.fromJson(e))
              .toList(),
      json["totalItems"],
    );
  }
}
