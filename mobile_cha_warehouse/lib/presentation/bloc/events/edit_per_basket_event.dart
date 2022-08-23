import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

abstract class EditPerBasketEvent extends Equatable {}

// class EditPerBasketEventEditQuantity extends EditPerBasketEvent {
//   final int currentQuantity;
//   final String quantityText;
//   final String productId;
//   EditPerBasketEventEditQuantity(
//       {required this.quantityText, required this.productId, required this.currentQuantity});
//   @override
//   List<Object> get props => [quantityText, productId, currentQuantity];
// }

// class EditPerBasketEventEditMass extends EditPerBasketEvent {
//   final int currentQuantity;
//   final String massText;
//   final String productId;
//   EditPerBasketEventEditMass(
//       {required this.massText, required this.productId, required this.currentQuantity});
//   @override
//   List<Object> get props => [massText, productId, currentQuantity];
// }
//
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
