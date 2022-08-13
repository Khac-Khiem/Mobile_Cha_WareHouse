import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

abstract class EditPerBasketEvent extends Equatable {}

class EditPerBasketEventEditQuantity extends EditPerBasketEvent {
  final int currentQuantity;
  final String quantityText;
  final String productId;
  EditPerBasketEventEditQuantity(
      {required this.quantityText, required this.productId, required this.currentQuantity});
  @override
  List<Object> get props => [quantityText, productId, currentQuantity];
}

class EditPerBasketEventEditMass extends EditPerBasketEvent {
  final int currentQuantity;
  final String massText;
  final String productId;
  EditPerBasketEventEditMass(
      {required this.massText, required this.productId, required this.currentQuantity});
  @override
  List<Object> get props => [massText, productId, currentQuantity];
}

class EditPerBasketEventEditClick extends EditPerBasketEvent {
  final ContainerInconsistency inconsistencyBasket;
  final bool isEditPeriodically;
  EditPerBasketEventEditClick(
      {required this.inconsistencyBasket, required this.isEditPeriodically});
  @override
  List<Object> get props => [inconsistencyBasket];
}
