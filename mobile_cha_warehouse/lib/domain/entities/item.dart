import 'package:equatable/equatable.dart';

enum EUnit { kilogram, pieces }

enum EItemSource { internal, external }

class Item extends Equatable {
  String itemId;
  String name;
  dynamic piecesPerKilogram;
  dynamic lifeCycle;
  // dynamic minimumStockLevel;
  // dynamic maximumStockLevel;
  int unit;
  // WarehouseEmployee manager;
  dynamic manager;
  bool hasManyUnits;
  Item(this.itemId, this.name, this.piecesPerKilogram, this.lifeCycle,
      this.unit, this.manager, this.hasManyUnits);

  @override
  // TODO: implement props
  List<Object?> get props => [itemId, name];
}
