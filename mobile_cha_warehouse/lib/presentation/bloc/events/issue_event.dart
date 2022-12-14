import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';
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

// kiểm tra thông tin rổ
class CheckInfoIssueEventRequested extends IssueEvent {
  String basketID;
  DateTime timeStamp; //Tạo timeStamp để lần nào click cũng khác nhau
  CheckInfoIssueEventRequested(
      {required this.timeStamp, required this.basketID});
  @override
  List<Object> get props =>
      [timeStamp, basketID]; //Với mỗi basket ID thì sẽ refresh lại
}

//sự kiện khi chọn đơn xuất kho
class ChooseIssueEvent extends IssueEvent {
  final String goodIssueId;
  final DateTime timestamp;
  ChooseIssueEvent(this.timestamp, this.goodIssueId);
  @override
  List<Object> get props => [timestamp, goodIssueId];
}

// chọn từng dòng trong đơn xuát kho
class ChooseIssueEntryEvent extends IssueEvent {
  String goodsIssueId;
  String itemId;
  DateTime timestamp;
  ChooseIssueEntryEvent(this.goodsIssueId, this.itemId, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}

// nút nhấn hoàn thành xuất kho 1 đơn
// gửi rổ lên server
// confirm
class ConFirmExportingContainer extends IssueEvent {
  DateTime timestamp;
  String issueId;
  //List<LotIssueExportServer> containers;
  List<Lots> lots;
  ConFirmExportingContainer(this.issueId, this.lots, this.timestamp);
  @override

  // TODO: implement props
  List<Object?> get props => [timestamp];
}

class AddLotFromSuggestToExpected extends IssueEvent {
  DateTime timestamp;
  Lots lot;
  AddLotFromSuggestToExpected(this.timestamp, this.lot);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}
// sự kiện load các rổ đã được xuất ứng với từng đơn
// class LoadContainerExportEvent extends IssueEvent {
//   DateTime timestamp;
//   String issueId;
//   String itemId;
//   LoadContainerExportEvent(this.timestamp, this.issueId, this.itemId);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [timestamp];
//}
