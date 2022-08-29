import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllDataEvent extends ReceiptEvent {
  //DateTime timestamp;
  LoadAllDataEvent();
  @override
  List<Object> get props => [];
}

class PostNewReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  List<GoodsReceiptEntryContainerData> goodsReceiptEntryContainers;
  String receiptId;
  PostNewReceiptEvent(
      this.goodsReceiptEntryContainers, this.timestamp, this.receiptId);
  @override
  List<Object> get props => [timestamp];
}

class UpdateLocationReceiptEvent extends ReceiptEvent {
  String containerId;
  String shelfid;
  int rowId;
  int id;
  UpdateLocationReceiptEvent(
      this.containerId, this.shelfid, this.rowId, this.id);
  @override
  List<Object> get props => [containerId];
}

class CheckContainerAvailableEvent extends ReceiptEvent {
  String containerId;
  DateTime timestamp;
  CheckContainerAvailableEvent(this.containerId, this.timestamp);
  @override
  List<Object> get props => [containerId, timestamp];
}

class LoadAllContainerExporting extends ReceiptEvent {
  DateTime timestamp;
  LoadAllContainerExporting(this.timestamp);
   @override
  List<Object> get props => [ timestamp];
}

class RefershReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  RefershReceiptEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
