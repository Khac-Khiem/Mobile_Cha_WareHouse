import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';

abstract class CheckInfoState extends Equatable {}

class CheckInfoStateLoading extends CheckInfoState {
  CheckInfoStateLoading();
  @override
  List<Object> get props => [];
}

class CheckInfoStateSuccess extends CheckInfoState {
  DateTime timeStamp;
  ContainerData basket;
  CheckInfoStateSuccess(this.basket, this.timeStamp);
  @override
  List<Object> get props => [basket, timeStamp];
}

// class CheckInfoStateFailure extends CheckInfoState {
//   ErrorPackage errorPackage;
//   CheckInfoStateFailure({this.errorPackage});
//   @override
//   List<Object> get props => [];
// }
class CheckInfoStateFailure extends CheckInfoState {
  CheckInfoStateFailure();
  @override
  List<Object> get props => [];
}

// class AddContainerStateSuccess extends CheckInfoState {
//   DateTime timeStamp;
//   AddContainerStateSuccess(this.timeStamp);

//   @override
//   // TODO: implement props
//   List<Object?> get props => [timeStamp];
// }
