import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class ContainerType {
  int weight;
  String name;
  ContainerType(this.name, this.weight);
}

// model du lieu cua mot ro
class ContainerData extends Equatable {
  String containerId;
  int? quantity;
  String? productionDate;
  bool isNotEmpty;
  Item? item;
  //ProductionEmployee? productionEmployee;
  Cell? location;
  ContainerType? containerType;
  ContainerData(
      this.containerId,
      this.quantity,
      this.productionDate,
      this.isNotEmpty,
      this.item,
      this.location,
     // this.productionEmployee,
      this.containerType);
  @override
  // TODO: implement props
  List<Object?> get props =>
      [containerId, quantity, productionDate, isNotEmpty, item, containerType];
}
