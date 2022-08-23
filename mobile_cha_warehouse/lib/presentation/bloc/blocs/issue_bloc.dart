import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import '../../screens/issue/issue_params.dart';

//tải các entry của một đơn từ server
List<GoodsIssueEntry> goodsIssueEntryData = [];
//lưu trữ các container để gửi lên server
List<ContainerIssueExportServer> goodsIssueEntryContainerData = [];
//Good Issue được chọn
String selectedGoodIssueId = '';
//lưu mã sản phẩm entry
String selectedItemId = '';
//Lấy all goodIssueId mà nhân công đó có, để đưa vô Dropdown Picker
List<String> goodIssueIdsView = [];

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueUseCase issueUseCase;
  ContainerUseCase containerUseCase;
  SlotUseCase slotUseCase;
  IssueBloc(
    this.issueUseCase,
    this.containerUseCase,
    this.slotUseCase,
  ) : super(IssueStateInitial()) {
    on<LoadIssueEvent>(_onLoadingIssue);
    on<ChooseIssueEvent>(_onChooseIssue);
    // on<AddContainerExport>(_onAddContainer);
    on<LoadContainerExportEvent>(_onLoadingContainer);
    on<ConFirmExportingContainer>(_onConfirm);
  }

  Future<void> _onLoadingIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is LoadIssueEvent) {
      emit(IssueStateInitial());
      try {
        selectedGoodIssueId = '';
        goodIssueIdsView = [];
        final allIssue = await issueUseCase.getAllIssues();
        if (allIssue.isNotEmpty) {
          for (int i = 0; i < allIssue.length; i++) {
            if (allIssue[i].isConfirmed == false) {
              goodIssueIdsView.add(allIssue[i].goodsIssueId);
            }
          }
          emit(IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView));
        } else {
          print('no data');
          emit(IssueStateLoadSuccess(DateTime.now(), []));
        }
      } catch (e) {
        print(e);
        emit(IssueStateFailure(DateTime.now()));
        // state fail
      }
    }
  }

  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryData.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          goodsIssueEntryData.add(
            issue.entries[i],
          );
        }

        emit(IssueStateListLoadSuccess(DateTime.now(), goodsIssueEntryData));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  // List<ContainerIssueExportServer> containers = [];
  // Future<void> _onAddContainer(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is AddContainerExport) {
  //     containers.add(event.containers);
  //     emit(AddContainerExportSuccess(containers));
  //   }
  // }
  List<ContainerIssueExportServer> container = [];
  double total = 0;
  Future<void> _onLoadingContainer(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is LoadContainerExportEvent) {
      container.clear();
      total = 0;
      if (goodsIssueEntryContainerData.isNotEmpty) {
        for (int i = 0; i < goodsIssueEntryContainerData.length; i++) {
          if (goodsIssueEntryContainerData[i].issueId == selectedGoodIssueId &&
              goodsIssueEntryContainerData[i].itemId == selectedItemId) {
            container.add(goodsIssueEntryContainerData[i]);
            total = total + goodsIssueEntryContainerData[i].quanlity;
          }
        }
        emit(LoadContainerExportStateSuccess(container, total, DateTime.now()));
      } else {
        emit(LoadContainerExportStateFail(DateTime.now()));
      }
    }
  }

  Future<void> _onConfirm(IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ConFirmExportingContainer) {
      emit(IssueStateConfirmLoading());
      try {
        final request = await
            issueUseCase.addContainerIssue(event.issueId, event.containers);
        final confirm = await issueUseCase.confirmGoodsIssue(event.issueId);
        if (confirm == 200 && request == 200) {
          print('success');
          emit(ConfirmSuccessIssueState(DateTime.now()));
        } else {
          emit(ConfirmFailureIssueState(DateTime.now()));
        }
      } catch (e) {
        print('fail');
        emit(ConfirmFailureIssueState(DateTime.now()));
      }
    }
  }

  // Future<void> _onReportBasket(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is ReportInconsistencyIssueEvent) {
  //     emit(ReportInconsistencyLoadingIssueState(DateTime.now()));
  //     try {
  //       // patch basket lỗi
  //       // final basketinconsistency = inconsistencyContainerUseCase
  //       //     .reportInconsistency(containerId, goodsIssueId, timeStamp);
  //       //    emit(ConfirmSuccessIssueState(DateTime.now()));
  //     } catch (e) {
  //       print('fail');
  //       //   emit(ConfirmFailureIssueState(DateTime.now()));
  //     }
  //   }
  // }

  // Future<void> _onRefresh(IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is TestIssueEvent) {
  //     print('aaaa');
  //     emit(IssueStateListRefresh(
  //         basketIssueIndex,
  //         goodsIssueEntryContainerData[basketIssueIndex]
  //             .goodsIssueEntryContainer
  //             .isTaken,
  //         DateTime.now()));
  //   }
  // }
}
