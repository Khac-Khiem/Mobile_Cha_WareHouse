import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';

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
  List<Object> get props => [timestamp, listIssueId];
}

class IssueStateListLoading extends IssueState {
  @override
  List<Object> get props => [];
}

class IssueStateListLoadSuccess extends IssueState {
  final DateTime timestamp; //Do mỗi lần book là nó sẽ trả ra state khác nhau
  List<GoodsIssueEntry> goodsIssueEntryData;
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

//Vì trong screen không gọi loadingDialog vượt class được, nên phải thêm stateLoading
class ReportInconsistencyLoadingIssueState extends IssueState {
  final DateTime timestamp;
  ReportInconsistencyLoadingIssueState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ReportInconsistencySuccessIssueState extends IssueState {
  final DateTime timestamp;
  ReportInconsistencySuccessIssueState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class ReportInconsistencyFailedIssueState extends IssueState {
  final DateTime timestamp;
  ReportInconsistencyFailedIssueState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoadLocationContainerSuccess extends IssueState {
  DateTime timeStamp;
  LoadLocationContainerSuccess(this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp];
}

class LoadingLocationState extends IssueState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadLocationFailState extends IssueState {
  DateTime timeStamp;
  LoadLocationFailState(this.timeStamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timeStamp];
}
