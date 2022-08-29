import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

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
  int statusRequest;
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

//
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

class RefershStateSuccess extends ReceiptState {
  DateTime timestamp;
  RefershStateSuccess(this.timestamp);
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

class LoadContainerExportingStateFail extends ReceiptState {
  DateTime timestamp;
  LoadContainerExportingStateFail(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadContainerExportingStateSuccess extends ReceiptState {
  DateTime timestamp;
  List<ContainerData> containers;
  LoadContainerExportingStateSuccess(this.timestamp, this.containers);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}
