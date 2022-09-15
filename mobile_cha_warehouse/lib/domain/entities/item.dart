import 'package:equatable/equatable.dart';

enum EUnit { kilogram, pieces }

enum EItemSource { internal, external }

class Item extends Equatable {
  String itemId;
  String name;
  dynamic piecesPerKilogram;
  dynamic minimumStockLevel;
  dynamic maximumStockLevel;
  int unit;
  // WarehouseEmployee manager;
  dynamic manager;
  Item(this.itemId, this.name, this.piecesPerKilogram, this.minimumStockLevel,
      this.maximumStockLevel, this.unit, this.manager);

  @override
  // TODO: implement props
  List<Object?> get props => [itemId, name];
}
