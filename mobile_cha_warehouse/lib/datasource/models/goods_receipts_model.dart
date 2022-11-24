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
     // bool isConfirmed,
      WarehouseEmployeeModel? employee,
      List<LotReceiptModel> lots)
      : super(goodsReceiptId, timestamp, employee, lots);
  factory GoodsReceiptsModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptsModel(
      json["goodsReceiptId"],
      json["timestamp"],
    //  json["isConfirmed"],
      json["employee"] == null
          ? null
          : WarehouseEmployeeModel.fromJson(json["employee"]),
      json ["lots"] == null
          ? []
          : (json["lots"] as List)
              .map((e) => LotReceiptModel.fromJson(e))
              .toList(),
    );
  }
}

class GoodsReceiptDataModel extends GoodsReceiptData {
  GoodsReceiptDataModel(int totalItem, List<GoodsReceiptsModel> items)
      : super(totalItem, items);
  factory GoodsReceiptDataModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptDataModel(
      json["totalItems"],
      json["items"] == null
          ? []
          : (json["items"] as List)
              .map((e) => GoodsReceiptsModel.fromJson(e))
              .toList(),
    );
  }
}

class LotReceiptModel extends LotReceipt {
  LotReceiptModel(String lotId, dynamic quantity, String date, Item? item)
      : super(lotId, quantity, date, item);
    factory LotReceiptModel.fromJson(Map<String, dynamic> json) {
    return LotReceiptModel(
      json["lotId"],
      json["quantity"],
      json["date"],
      json["item"] == null ? null : ItemModel.fromJson(json["item"]), 
    );
  }
}

class UnlocatedLotReceiptModel extends UnlocatedLotReceipt {
  UnlocatedLotReceiptModel(String goodsReceiptId, String lotId, dynamic quantity, String date, Item? item)
      : super(goodsReceiptId, lotId, quantity, date, item);
    factory UnlocatedLotReceiptModel.fromJson(Map<String, dynamic> json) {
    return UnlocatedLotReceiptModel(
      json["goodsReceiptId"],
      json["lotId"],
      json["quantity"],
      json["date"],
      json["item"] == null ? null : ItemModel.fromJson(json["item"]), 
    );
  }
}
