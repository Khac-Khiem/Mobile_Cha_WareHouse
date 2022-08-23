import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

abstract class IssueEvent extends Equatable {}

// sự kiện load tất cả đơn xuất kho về
// nút nhấn xuất kho
class LoadIssueEvent extends IssueEvent {
  final String startDate;
  final DateTime timestamp;
  LoadIssueEvent(this.timestamp, this.startDate);
  @override
  List<Object> get props => [timestamp];
}

//sự kiện khi chọn đơn xuất kho
class ChooseIssueEvent extends IssueEvent {
  final String goodIssueId;
  final DateTime timestamp;
  ChooseIssueEvent(this.timestamp, this.goodIssueId);
  @override
  List<Object> get props => [timestamp, goodIssueId];
}

// nút nhấn hoàn thành xuất kho 1 đơn
// gửi rổ lên server
// confirm 
class ConFirmExportingContainer extends IssueEvent {
  DateTime timestamp;
  String issueId;
  List<ContainerIssueExportServer> containers;
  ConFirmExportingContainer(this.issueId, this.containers, this.timestamp);
  @override

  // TODO: implement props
  List<Object?> get props => [timestamp];
}

// class AddContainerExport extends IssueEvent {
//   ContainerIssueExportServer containers;
//   AddContainerExport(this.containers);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [containers];
// }

// sự kiện load các rổ đã được xuất ứng với từng đơn
class LoadContainerExportEvent extends IssueEvent {
  DateTime timestamp;
  String issueId;
  String itemId;
  LoadContainerExportEvent(this.timestamp, this.issueId, this.itemId);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}
