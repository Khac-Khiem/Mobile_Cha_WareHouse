import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

import '../../../domain/entities/error_package.dart';
import '../../../domain/entities/lots_data.dart';

abstract class EditPerBasketState extends Equatable {}

class EditPerBasketStateInit extends EditPerBasketState {
  @override
  List<Object> get props => [];
}

class InventoryStateLoadingProduct extends EditPerBasketState {
  @override
  List<Object> get props => [];
}

class InventoryStateLoadProductSuccess extends EditPerBasketState {
  List<String> listItemId;
  DateTime timeStamp;
  InventoryStateLoadProductSuccess(this.listItemId, this.timeStamp);
  @override
  List<Object> get props => [timeStamp];
}

class InventoryStateLoadingLot extends EditPerBasketState {
  DateTime timestamp;
  InventoryStateLoadingLot(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class InventoryStateLoadLotSuccess extends EditPerBasketState {
  List<Lots> listLots;
  DateTime timeStamp;
  InventoryStateLoadLotSuccess(this.listLots, this.timeStamp);
  @override
  List<Object> get props => [timeStamp];
}

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
