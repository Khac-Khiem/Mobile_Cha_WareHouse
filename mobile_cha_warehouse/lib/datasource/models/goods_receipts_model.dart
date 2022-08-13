import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/production_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class GoodsReceiptContainerModel extends GoodsReceiptContainer {
  GoodsReceiptContainerModel(
      int goodsReceiptEntryId,
      String containerId,
      double quantity,
      DateTime productionDate,
      Item item,
      ProductionEmployee productionEmployee)
      : super(goodsReceiptEntryId, containerId, quantity, productionDate, item,
            productionEmployee);
  factory GoodsReceiptContainerModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptContainerModel(
      json["goodsReceiptEntryId"],
      json["containerId"],
      json["quantity"],
      json["productionDate"],
      json["item"] == null ? null! : ItemModel.fromJson(json["item"]),
      json["productionEmployee"] == null
          ? null!
          : ProductionEmployeeModel.fromJson(json["productionEmployee"]),
    );
  }
}

class GoodsReceiptsModel extends GoodsReceipt {
  GoodsReceiptsModel(
      String goodsReceiptId,
      String timestamp,
      bool isConfirmed,
      WarehouseEmployeeModel? approver,
      List<GoodsReceiptContainerModel> entries)
      : super(goodsReceiptId, timestamp, isConfirmed, approver, entries);
  factory GoodsReceiptsModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptsModel(
      json["goodsReceiptId"],
      json["timestamp"],
      json["confirmed"],
      json["approver"] == null
          ? null
          : WarehouseEmployeeModel.fromJson(json["approver"]),
      json["entries"] == null
          ? []
          : (json["entries"] as List)
              .map((e) => GoodsReceiptContainerModel.fromJson(e))
              .toList(),
    );
  }
}

// class GoodsReceiptDataModel extends GoodsReceiptData {
//   GoodsReceiptDataModel(int totalItem, List<GoodsReceiptsModel> items)
//       : super(totalItem, items);
//   factory GoodsReceiptDataModel.fromJson(Map<String, dynamic> json) {
//     return GoodsReceiptDataModel(
//       json["totalItems"],
//       json["items"] == null
//           ? []
//           : (json["items"] as List)
//               .map((e) => GoodsReceiptsModel.fromJson(e))
//               .toList(),
//     );
//   }
// }
