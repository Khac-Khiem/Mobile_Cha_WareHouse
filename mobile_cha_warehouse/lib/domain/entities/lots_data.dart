import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class Lots extends Equatable {
  String lotId;
  Cell? cell;
  int quantity;
  String date;
  Item? item;
  Lots(this.lotId, this.cell, this.quantity, this.date, this.item);
  @override
  // TODO: implement props
  List<Object?> get props => [lotId];
}
