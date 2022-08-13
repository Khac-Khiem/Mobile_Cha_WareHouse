import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

class Cell extends Equatable {
  String? shelfId;
  int? rowId;
  int? id;
  int? capacity;
  List<ContainerData>? containers;
  Cell({this.shelfId, this.rowId, this.id, this.capacity, this.containers});

  @override
  // TODO: implement props
  List<Object?> get props => [shelfId, rowId, id];
}
