import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

// model lưu trữ từng rổ của một dòng trong đơn xuất kho
class GoodsIssueEntryContainer extends Equatable {
  //int goodsIssueEntryId;
  dynamic quantity;
  String productionDate;
  String containerId;
  //bool isTaken;
  ProductionEmployee? productionEmployee;
  GoodsIssueEntryContainer( this.quantity,
      this.productionDate, this.containerId, this.productionEmployee);
  @override
  // TODO: implement props
  List<Object?> get props => [quantity, productionDate, containerId];
}

// từng dòng của một đơn xuất kho
class GoodsIssueEntry extends Equatable {
 // int id;
 // int goodsIssueId;
 // int itemId;
  dynamic plannedQuantity;
 // WarehouseEmployee employee;
  Item item;
  List<GoodsIssueEntryContainer>? container;
  //List<dynamic> container;
  GoodsIssueEntry(this.plannedQuantity,
      this.item, this.container);
  @override
  // TODO: implement props
  List<Object?> get props => [plannedQuantity, item, container];
}

//Model của một đơn xuất kho
class GoodsIssue extends Equatable {
  String goodsIssueId;
  String timestamp;
  bool isConfirmed;
  WarehouseEmployee employee;
  List<GoodsIssueEntry> entries;
  GoodsIssue(this.goodsIssueId, this.timestamp,this.employee, this.isConfirmed, this.entries);
  @override
  // TODO: implement props
  List<Object?> get props => [goodsIssueId, timestamp, isConfirmed, entries];
}

////////
class GoodsIssueData extends Equatable {
  List<GoodsIssue> items;
  int total;
  GoodsIssueData(this.items, this.total);
  @override
  // TODO: implement props
  List<Object?> get props => [items, total];
}
