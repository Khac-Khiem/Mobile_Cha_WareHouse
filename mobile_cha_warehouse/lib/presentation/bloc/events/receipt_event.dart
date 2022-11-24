import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllDataEvent extends ReceiptEvent {
  DateTime timestamp;
  LoadAllDataEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class PostNewReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  List<GoodsReceiptEntryContainerData> lots;
  String receiptId;
  PostNewReceiptEvent(this.lots, this.timestamp, this.receiptId);
  @override
  List<Object> get props => [timestamp];
}

class UpdateLocationReceiptEvent extends ReceiptEvent {
  String receiptId;
  String lotId;
  String shelfid;
  int rowId;
  int id;
  UpdateLocationReceiptEvent(
      this.receiptId, this.lotId, this.shelfid, this.rowId, this.id);
  @override
  List<Object> get props => [lotId];
}

//-----------------------
class CheckContainerAvailableEvent extends ReceiptEvent {
  String containerId;
  DateTime timestamp;
  CheckContainerAvailableEvent(this.containerId, this.timestamp);
  @override
  List<Object> get props => [containerId, timestamp];
}
//--------------------------


class LoadAllReceiptExported extends ReceiptEvent {
  DateTime timestamp;
  LoadAllReceiptExported(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class RefershReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  RefershReceiptEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoadReceiptHistoryEvent extends ReceiptEvent {
  DateTime timestamp;
  DateTime startdate;
  DateTime enddate;
  LoadReceiptHistoryEvent(this.timestamp, this.startdate, this.enddate);
  @override
  List<Object> get props => [timestamp];
}

class LoadAllShelfEvent extends ReceiptEvent {
  DateTime timestamp;
  LoadAllShelfEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoadUnlocatedLotEvent extends ReceiptEvent {
  DateTime timestamp;
  LoadUnlocatedLotEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class UpdateQuantityReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  String receiptId;
  String lotId;
  dynamic quantity;
  UpdateQuantityReceiptEvent(
      this.lotId, this.quantity, this.receiptId, this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
