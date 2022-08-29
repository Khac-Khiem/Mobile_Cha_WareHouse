import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/good_issue.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import '../../screens/issue/issue_params.dart';

//tải các entry của một đơn từ server
List<GoodsIssueEntry> goodsIssueEntryDataTemp = [];
// tải các rổ đã xuất trong một đơn từ server
//List<GoodsIssueEntryContainer>? containerExported = [];
//lưu trữ các container để gửi lên server
List<ContainerIssueExportServer> goodsIssueEntryContainerData = [];
//
int planned = 0;
//
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
    on<CheckInfoIssueEventRequested>(_onLoadingInfo);
    on<ChooseIssueEntryEvent>(_onChooseEntry);
    //on<LoadContainerExportEvent>(_onLoadingContainer);
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

  Future<void> _onLoadingInfo(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is CheckInfoIssueEventRequested) {
      emit(CheckInfoStateLoading(DateTime.now()));
      try {
        final basketOrErr =
            await containerUseCase.getContainerById(event.basketID);
        emit(CheckInfoIssueStateSuccess(basketOrErr, DateTime.now()));
      } catch (e) {
        print(e);
        emit(CheckInfoStateFailure());
      }
    }
  }

  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryDataTemp.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          goodsIssueEntryDataTemp.add(
            issue.entries[i],
          );
        }
        emit(
            IssueStateListLoadSuccess(DateTime.now(), goodsIssueEntryDataTemp));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onChooseEntry(
      IssueEvent event, Emitter<IssueState> emit) async {
    emit(IssueStateListLoading());
    try {
      if (event is ChooseIssueEntryEvent) {
       double total = 0;
        final goodsIssue = await issueUseCase.getIssueById(selectedGoodIssueId);
        for (var element in goodsIssue.entries) {
          if (element.item.itemId == selectedItemId) {
            if (element.container != []) {
              container = element.container!;
              for (var item in element.container!) {
                total = total + item.quantity;
              }
            } else {
              container = [];
            }
          }
        }

        emit(LoadContainerExportStateSuccess(container, total, DateTime.now()));
      }
    } catch (e) {
      emit(IssueStateFailure(DateTime.now()));
    }
  }

  List<GoodsIssueEntryContainer> container = [];
  // Future<void> _onLoadingContainer(
  //     IssueEvent event, Emitter<IssueState> emit) async {
  //   emit(IssueStateListLoading());
  //   try {
  //     if (event is LoadContainerExportEvent) {
  //       container.clear();
  //       // total = 0;
  //       if (goodsIssueEntryContainerData.isNotEmpty
  //           // ||
  //           //     containerExported!.isNotEmpty
  //           ) {
  //         for (int i = 0; i < goodsIssueEntryContainerData.length; i++) {
  //           if (goodsIssueEntryContainerData[i].issueId ==
  //                   selectedGoodIssueId &&
  //               goodsIssueEntryContainerData[i].itemId == selectedItemId) {
  //             container.add(goodsIssueEntryContainerData[i]);
  //             total = total + goodsIssueEntryContainerData[i].quantity;
  //             //     containerExported![i].quantity;
  //           }
  //         }
  //         emit(LoadContainerExportStateSuccess(
  //             container, total, DateTime.now()));
  //       } else {
  //         emit(LoadContainerExportStateFail(DateTime.now()));
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> _onConfirm(IssueEvent event, Emitter<IssueState> emit) async {
    if (event is ConFirmExportingContainer) {
      emit(IssueStateConfirmLoading());
      try {
        final request = await issueUseCase.addContainerIssue(
            event.issueId, event.containers);
        // final confirm = await issueUseCase.confirmGoodsIssue(event.issueId);
        if (request == 200) {
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
}
