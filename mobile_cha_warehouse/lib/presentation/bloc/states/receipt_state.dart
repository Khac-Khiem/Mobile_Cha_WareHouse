import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';

import '../../screens/receipt/receipt_params.dart';

abstract class ReceiptState extends Equatable {}

class ReceiptInitialState extends ReceiptState {
  @override
  List<Object> get props => [];
}

class ReceiptLoadingState extends ReceiptState {
  DateTime timestamp;
  ReceiptLoadingState(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

//
class PostReceiptStateSuccess extends ReceiptState {
  ErrorPackage statusRequest;
  DateTime timestamp;
  PostReceiptStateSuccess(this.timestamp, this.statusRequest);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class PostReceiptStateFailure extends ReceiptState {
  String error;
  DateTime timestamp;
  PostReceiptStateFailure(this.error, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

//-------------------
class UpdateLocationReceiptStateSuccess extends ReceiptState {
  DateTime timestamp;
  UpdateLocationReceiptStateSuccess(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class UpdateLocationReceiptStateFailure extends ReceiptState {
  DateTime timestamp;
  UpdateLocationReceiptStateFailure(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class CheckContainerStateFail extends ReceiptState {
  DateTime timestamp;
  String error;
  CheckContainerStateFail(this.timestamp, this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class CheckContainerStateSuccess extends ReceiptState {
  DateTime timestamp;
  CheckContainerStateSuccess(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadReceiptExportingStateFail extends ReceiptState {
  DateTime timestamp;
  LoadReceiptExportingStateFail(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadReceiptExportingStateSuccess extends ReceiptState {
  DateTime timestamp;
  List<GoodsReceiptsModel> receipts;
  LoadReceiptExportingStateSuccess(this.timestamp, this.receipts);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

//----------------------------------
class RefershStateSuccess extends ReceiptState {
  DateTime timestamp;
  RefershStateSuccess(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}


class HistoryStateLoadSuccess extends ReceiptState {
  final DateTime timestamp;
  final GoodsReceiptData lots;
  HistoryStateLoadSuccess(this.timestamp, this.lots);
  @override
  List<Object> get props => [timestamp];
}

class HistoryStateLoadFailed extends ReceiptState {
  //final ErrorPackage errorPackage;
  HistoryStateLoadFailed();
  @override
  List<Object> get props => [];
}

class LoadAllShelfSuccess extends ReceiptState {
  DateTime timestamp;
  List<String> shelfIds;
  LoadAllShelfSuccess(this.shelfIds, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadUnlocatedLotSuccess extends ReceiptState {
  DateTime timestamp;
  List<UnlocatedLotReceipt> receipts;
  LoadUnlocatedLotSuccess(this.receipts, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UpdateQuantitySuccess extends ReceiptState {
  DateTime timestamp;
  UpdateQuantitySuccess(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}


class UpdateQuantityFail extends ReceiptState {
  DateTime timestamp;
  UpdateQuantityFail(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}