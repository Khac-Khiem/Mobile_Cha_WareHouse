import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';

import '../../../domain/entities/lots_data.dart';
import '../../screens/issue/issue_params.dart';

abstract class IssueState extends Equatable {}

class IssueStateInitial extends IssueState {
  @override
  List<Object> get props => [];
}

class IssueStateFailure extends IssueState {
  final DateTime timestamp;
  //final ErrorPackage errorPackage;
  IssueStateFailure(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class IssueStateLoadSuccess extends IssueState {
  final DateTime timestamp;
  final List<String> listIssueId;
  IssueStateLoadSuccess(this.timestamp, this.listIssueId);
  @override
  List<Object> get props => [timestamp];
}

class CheckInfoIssueStateSuccess extends IssueState {
  final DateTime timeStamp;
  final ContainerData basket;
  CheckInfoIssueStateSuccess(this.basket, this.timeStamp);
  @override
  List<Object> get props => [basket, timeStamp];
}

class CheckInfoStateLoading extends IssueState {
  DateTime timestamp;
  CheckInfoStateLoading(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class CheckInfoStateFailure extends IssueState {
  CheckInfoStateFailure();
  @override
  List<Object> get props => [];
}

class IssueStateListLoading extends IssueState {
  @override
  List<Object> get props => [];
}

class IssueStateListLoadSuccess extends IssueState {
  final DateTime timestamp; //Do mỗi lần book là nó sẽ trả ra state khác nhau
  List<GoodsIssueEntryView> goodsIssueEntryData;
  IssueStateListLoadSuccess(this.timestamp, this.goodsIssueEntryData);
  @override
  List<Object> get props => [timestamp];
}

// refresh after click toggle
class IssueStateListRefresh extends IssueState {
  final int index;
  final bool entryStatus;
  final DateTime timestamp; //Để có thể cập nhật toggle và toggle inconsistency
  IssueStateListRefresh(this.index, this.entryStatus, this.timestamp);
  @override
  List<Object> get props => [index, entryStatus, timestamp];
}

class IssueStateConfirmLoading extends IssueState {
  @override
  List<Object> get props => [];
}

class ConfirmSuccessIssueState extends IssueState {
  final DateTime timestamp;
  ConfirmSuccessIssueState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ConfirmFailureIssueState extends IssueState {
  final DateTime timestamp;

  ConfirmFailureIssueState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoadContainerExportStateSuccess extends IssueState {
  DateTime timestamp;
  List<GoodsIssueEntryContainer> containers;
  double totalQuatity;
  LoadContainerExportStateSuccess(
      this.containers, this.totalQuatity, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadContainerExportStateFail extends IssueState {
  DateTime timestamp;
  LoadContainerExportStateFail(this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class LoadLotSuccess extends IssueState {
  DateTime timestamp;
  List<Lots> listLotsSuggest;
  List<Lots> listLotExpected;
  LoadLotSuccess(this.timestamp, this.listLotsSuggest, this.listLotExpected);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}
