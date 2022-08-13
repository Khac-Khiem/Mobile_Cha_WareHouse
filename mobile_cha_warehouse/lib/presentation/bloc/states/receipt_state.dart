import 'package:equatable/equatable.dart';

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
  DateTime timestamp;
  PostReceiptStateFailure(this.timestamp);
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
