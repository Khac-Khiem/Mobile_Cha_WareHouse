import 'package:equatable/equatable.dart';

abstract class StockCardViewEvent extends Equatable {}

class StockCardViewEventLoadAllProductID extends StockCardViewEvent {
  final DateTime timestamp;
  StockCardViewEventLoadAllProductID(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class StockCardViewEventSelectProductId extends StockCardViewEvent {
  final String productId;
  StockCardViewEventSelectProductId(this.productId);
  @override
  List<Object> get props => [productId];
}

class StockCardViewEventLoad extends StockCardViewEvent {
  final DateTime timestamp;
  final String productId;
  final DateTime startDate;
  final DateTime endDate;
  StockCardViewEventLoad(
      this.timestamp, this.productId, this.startDate, this.endDate);
  @override
  List<Object> get props => [timestamp];
}
