import 'package:equatable/equatable.dart';
import 'cell_data.dart';

class Shelf extends Equatable {
  String shelfId;
  List<Cell> cells;
  int priority;

  Shelf(this.shelfId, this.cells, this.priority);
  @override
  // TODO: implement props
  List<Object?> get props => [shelfId];
}
