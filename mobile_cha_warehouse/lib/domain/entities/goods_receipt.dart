import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class GoodsReceiptContainer extends Equatable {
  int goodsReceiptEntryId;
  String containerId;
  double quantity;
  DateTime productionDate;
  Item item;
  ProductionEmployee productionEmployee;

  GoodsReceiptContainer(this.goodsReceiptEntryId, this.containerId,
      this.quantity, this.productionDate, this.item, this.productionEmployee);
  @override
  // TODO: implement props
  List<Object?> get props => [productionDate, containerId];
}

class GoodsReceipt extends Equatable {
  String goodsReceiptId;
  String timestamp;
 // bool isConfirmed;
  WarehouseEmployee? employee;
  //dynamic approver;
  List<LotReceipt> lots;
  GoodsReceipt(this.goodsReceiptId, this.timestamp,
      this.employee, this.lots);
  @override
  // TODO: implement props
  List<Object?> get props => [goodsReceiptId, timestamp, lots];
}

class GoodsReceiptData extends Equatable {
  int totalItem;
  List<GoodsReceipt> items;
  GoodsReceiptData(this.totalItem, this.items);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LotReceipt extends Equatable {
  String lotId;
  dynamic quantity;
  String date;
  Item? item;
  LotReceipt(this.lotId, this.quantity, this.date, this.item);
  @override
  // TODO: implement props
  List<Object?> get props => [lotId];
}

class UnlocatedLotReceipt extends Equatable {
  String goodsReceiptId;
  String lotId;
  dynamic quantity;
  String date;
  Item? item;
  UnlocatedLotReceipt(this.goodsReceiptId, this.lotId, this.quantity, this.date, this.item);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
