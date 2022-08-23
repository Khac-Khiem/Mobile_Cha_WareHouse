import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

import '../../../domain/entities/error_package.dart';

abstract class EditPerBasketState extends Equatable {}
class EditPerBasketStateInit extends EditPerBasketState {
  @override
  List<Object> get props => [];
}
// class EditPerBasketStateRefresh extends EditPerBasketState {
//   final double mass;
//   final int quantity;
//   final String note;
//   EditPerBasketStateRefresh({required this.mass, required this.quantity, required this.note});
//   @override
//   List<Object> get props => [mass, quantity, note];
// }

// class EditPerBasketStateRefreshFailed extends EditPerBasketState {

//   final ErrorPackage errorPackage;
//   EditPerBasketStateRefreshFailed(this.errorPackage);
//   @override
//   List<Object> get props => [errorPackage];
// }
class CheckInfoInventoryStateSuccess extends EditPerBasketState {
  DateTime timeStamp;
  ContainerData basket;
  CheckInfoInventoryStateSuccess(this.basket, this.timeStamp);
  @override
  List<Object> get props => [basket, timeStamp];
}

// class CheckInfoStateFailure extends CheckInfoState {
//   ErrorPackage errorPackage;
//   CheckInfoStateFailure({this.errorPackage});
//   @override
//   List<Object> get props => [];
// }
class CheckInfoInventoryStateFailure extends EditPerBasketState {
  CheckInfoInventoryStateFailure();
  @override
  List<Object> get props => [];
}
class EditPerBasketStateUploadLoading extends EditPerBasketState {
  @override
  List<Object> get props => [];
}

class EditPerBasketStateUploadSuccess extends EditPerBasketState {
  DateTime timestamp;
  EditPerBasketStateUploadSuccess(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class EditPerBasketStateUploadFailed extends EditPerBasketState {
  final ErrorPackage errorPackage;
  EditPerBasketStateUploadFailed(this.errorPackage);
  @override
  List<Object> get props => [errorPackage];
}
