import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/warehouse_employee.dart';

class ContainerInconsistency extends Equatable {
  DateTime timestamp;
  String containerId;
  String shelfUnitId;
  String goodsIssuId;
  int currentQuantity;
  int newQuantity;
  String note;
  bool isFixed;
  Item item;
  WarehouseEmployee reporter;
  ContainerInconsistency(
      this.timestamp,
      this.containerId,
      this.shelfUnitId,
      this.goodsIssuId,
      this.currentQuantity,
      this.newQuantity,
      this.note,
      this.isFixed,
      this.reporter,
      this.item);

  @override
  // TODO: implement props
  List<Object?> get props => [timestamp, containerId, shelfUnitId, goodsIssuId, currentQuantity,newQuantity, note, isFixed, reporter, item];
}
