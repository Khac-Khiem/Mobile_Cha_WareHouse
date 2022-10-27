import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

abstract class EditPerBasketEvent extends Equatable {}

class LoadAllItemIInventoryEvent extends EditPerBasketEvent {
  DateTime timestamp;
  LoadAllItemIInventoryEvent(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadLotInventoryEvent extends EditPerBasketEvent {
  String itemId;
  LoadLotInventoryEvent(this.itemId);
  @override
  // TODO: implement props
  List<Object?> get props => [itemId];
}

class CheckInfoInventoryEvent extends EditPerBasketEvent {
  String basketID;
  DateTime timeStamp; //Tạo timeStamp để lần nào click cũng khác nhau
  CheckInfoInventoryEvent({required this.timeStamp, required this.basketID});
  @override
  List<Object> get props =>
      [timeStamp, basketID]; //Với mỗi basket ID thì sẽ refresh lại
}

class EditPerBasketEventEditClick extends EditPerBasketEvent {
  String containerId;
  String note;
  int newQuantity;
  DateTime timeStamp;
  EditPerBasketEventEditClick(
      this.containerId, this.note, this.newQuantity, this.timeStamp);
  @override
  List<Object> get props => [timeStamp];
}
