import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/slot_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/issue_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/issue_state.dart';
import '../../../domain/entities/lots_data.dart';
import '../../screens/issue/issue_params.dart';

//tải các entry của một đơn từ server
List<GoodsIssueEntryView> goodsIssueEntryDataTemp = [];
//lưu trữ các container để gửi lên server
//List<LotIssueExportServer> listLotExport = [];
List<Lots> listLotExportServer = [];
List<Lots> listLotSuggest = [];
//
int planned = 0;
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
    on<AddLotFromSuggestToExpected>(_onChanged);
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
        emit(CheckInfoStateFailure());
      }
    }
  }

  Future<void> _onChooseIssue(
      IssueEvent event, Emitter<IssueState> emit) async {
    num quantity = 0;
    if (event is ChooseIssueEvent) {
      emit(IssueStateListLoading());
      try {
        goodsIssueEntryDataTemp.clear();
        final issue = await issueUseCase.getIssueById(event.goodIssueId);
        for (int i = 0; i < issue.entries.length; i++) {
          quantity = 0;
          if (issue.entries[i].container != []) {
            issue.entries[i].container!.forEach((element) {
              quantity += element.quantity;
            });
          }

          goodsIssueEntryDataTemp.add(GoodsIssueEntryView(
              issue.entries[i].item.itemId,
              issue.entries[i].plannedQuantity,
              int.parse(quantity.toString())));
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
    if (event is ChooseIssueEntryEvent) {
      emit(IssueStateListLoading());
      try {
        final lots = await issueUseCase.getLotByItemId(event.itemId);
        listLotSuggest = lots;
        emit(LoadLotSuccess(DateTime.now(), lots, []));
      } catch (e) {
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  Future<void> _onChanged(IssueEvent event, Emitter<IssueState> emit) async {
    List<Lots> lots = [];
    List<Lots> listLotTemp = listLotExportServer;
    bool check = true;

    if (event is AddLotFromSuggestToExpected) {
      emit(IssueStateListLoading());
      try {
        for (var element in listLotSuggest) {
          if (element.lotId == event.lot.lotId) {
            element.quantity = element.quantity - event.lot.quantity;
          }
        }
        lots = listLotSuggest..removeWhere((element) => element.quantity == 0);
        print(lots);

        if (listLotExportServer.isNotEmpty) {
          for (var element in listLotExportServer) {
            if (element.lotId == event.lot.lotId) {
              element.quantity = element.quantity + event.lot.quantity;
              check = false;
            }
            // else {
            //   listLotTemp.clear();
            //   // thay dổi kích thước list trong for => error
            //   listLotTemp.add(event.lot);
            // }
          }
        
       check
              ? listLotExportServer.add(event.lot)
              : {};
          // listLotTemp == listLotExportServer ?{}:
          // listLotExportServer.add(listLotTemp[0]);
        } else {
          listLotExportServer.add(event.lot);
        }

        //listLotExportServer.add(event.lot);
        emit(LoadLotSuccess(DateTime.now(), lots, listLotExportServer));
      } catch (e) {
        print(e);
        //emit(LoadLotSuccess(DateTime.now(), lots, listLotExportServer));
        emit(IssueStateFailure(DateTime.now()));
      }
    }
  }

  // List<GoodsIssueEntryContainer> container = [];
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
        final request =
            await issueUseCase.addContainerIssue(event.issueId, event.lots);
        // final confirm = await issueUseCase.confirmGoodsIssue(event.issueId);
        if (request.errorMessage == "success") {
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
