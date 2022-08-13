import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/inconsistency_container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/list_issue_entry_screen.dart';

import '../../screens/issue/issue_params.dart';

//
List<GoodsIssueEntry> goodsIssueEntryData = [];
//
List<GoodsIssueEntryContainer> goodsIssueEntryContainerData = [];
//Lấy all goodIssueId mà nhân công đó có, để đưa vô Dropdown Picker
List<String> goodIssueIdsView = [];
//Good Issue mà dropdown chọn
String selectedGoodIssueId = '';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueUseCase issueUseCase;
  ContainerUseCase containerUseCase;
  InconsistencyContainerUseCase inconsistencyContainerUseCase;
  SlotUseCase slotUseCase;
  IssueBloc(this.issueUseCase, this.containerUseCase, this.slotUseCase,
      this.inconsistencyContainerUseCase)
      : super(IssueStateInitial()) {
    on<LoadIssueEvent>(_onLoadingIssue);
    on<ChooseIssueEvent>(_onChooseIssue);
    on<ConFirmExportingContainer>(_onConfirm);
  }
  Future<void> _onLoadingIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is LoadIssueEvent) {
      emit(IssueStateInitial());
      try {
        selectedGoodIssueId = '';
        goodsIssueEntryContainerData = [];
        goodIssueIdsView = [];
        goodsIssueEntryData = [];
        final allIssue = await issueUseCase.getAllIssues(event.startDate);
        if (allIssue.isNotEmpty) {
          for (int i = 0; i < allIssue.length; i++) {
            if (allIssue[i].isConfirmed == false) {
              goodIssueIdsView.add(allIssue[i].goodsIssueId);
            }
          }
          emit(IssueStateLoadSuccess(DateTime.now(), goodIssueIdsView));
        } else {
          print('error');
          emit(IssueStateLoadSuccess(DateTime.now(), []));
        }
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
        // state fail
      }
    }
  }

// pros goodsIssueEntryData đưa vào State IssueStateListloadSuccess
  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryData.clear();
        listBasketIdConfirm.clear();
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

  // Future<void> _onClickContainerToggle(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is ToggleContainerIssueEvent) {
  //     goodsIssueEntryContainerData[basketIssueIndex]
  //             .goodsIssueEntryContainer
  //             .isTaken =
  //         !goodsIssueEntryContainerData[basketIssueIndex]
  //             .goodsIssueEntryContainer
  //             .isTaken;
  //     emit(IssueStateListRefresh(
  //         basketIssueIndex,
  //         goodsIssueEntryContainerData[basketIssueIndex]
  //             .goodsIssueEntryContainer
  //             .isTaken,
  //         DateTime.now()));
  //   }
  // }

  // Future<void> _onLoadLocation(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   if (event is FetchLocationIssueEvent) {
  //     emit(LoadingLocationState());
  //     try {
  //       print('a');
  //       //
  //       final cell = await slotUseCase.getCellById(event.id);
  //       xAxis = cell.slices!.length;
  //       for (int i = 0; i < cell.slices!.length; i++) {
  //         for (int j = 1; j < cell.slices![i].slots!.length; j++) {
  //           if (cell.slices![i].slots![j].levelId! >
  //               cell.slices![i].slots![j - 1].levelId!) {
  //             yAxis = cell.slices![i].slots![j].levelId!;
  //           }
  //           if (cell.slices![i].slots![j].id! >
  //               cell.slices![i].slots![j - 1].id!) {
  //             zAxis = cell.slices![i].slots![j].id!;
  //           }
  //         }
  //       }

  //       locationContainer.clear();
  //       final container = await containerUseCase.getContainerById(event.id);
  //       locationContainer.add(container.storageSlot);
  //       // print(
  //       //     locationContainer[0].shelfId + locationContainer[0].id.toString());
  //       emit(LoadLocationContainerSuccess(DateTime.now()));
  //     } catch (e) {
  //       print('b');
  //       emit(LoadLocationFailState(DateTime.now()));
  //     }
  //   }
  // }

  Future<void> _onConfirm(IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ConFirmExportingContainer) {
      emit(IssueStateConfirmLoading());
      try {
        final confirm = issueUseCase.patchConfirmIssueEntry(
            event.issueId, event.containerId);
        emit(ConfirmSuccessIssueState(DateTime.now()));
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
