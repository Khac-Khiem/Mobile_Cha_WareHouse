import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/datasource/models/stockcard_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';

abstract class StockCardViewState extends Equatable {}

class StockCardViewStateLoadingProduct extends StockCardViewState {
  @override
  List<Object> get props => [];
}

class StockCardViewStateLoadProductSuccess extends StockCardViewState {
  DateTime timeStamp;
  StockCardViewStateLoadProductSuccess(this.timeStamp);
  @override
  List<Object> get props => [timeStamp];
}

class StockCardViewStateSelectedProductID extends StockCardViewState {
  final String productName;
  StockCardViewStateSelectedProductID(this.productName);
  @override
  List<Object> get props => [productName];
}

class StockCardViewStateLoading extends StockCardViewState {
  StockCardViewStateLoading();
  @override
  List<Object> get props => [];
}

class StockCardViewStateLoadSuccess extends StockCardViewState {
  final DateTime timestamp;
  final List<StockCardEntry> stockCard;
  StockCardViewStateLoadSuccess(this.timestamp, this.stockCard);
  @override
  List<Object> get props => [timestamp, stockCard];
}

class StockCardViewStateLoadFailed extends StockCardViewState {
  //final ErrorPackage errorPackage;
  StockCardViewStateLoadFailed();
  @override
  List<Object> get props => [];
}
