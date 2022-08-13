import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class LoadAllReceiptEvent extends ReceiptEvent {
//   String startDate;
//   DateTime timestamp;
//   LoadAllReceiptEvent(this.timestamp, this.startDate);
//   @override
//   List<Object> get props => [timestamp];
// }
class PostNewReceiptEvent extends ReceiptEvent {
  DateTime timestamp;
  List<GoodsReceiptEntryContainerData> goodsReceiptEntryContainers;
  String receiptId;
  PostNewReceiptEvent(this.goodsReceiptEntryContainers, this.timestamp, this.receiptId);
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
