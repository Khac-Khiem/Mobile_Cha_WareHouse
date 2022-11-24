import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/production_employee_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import '../../../domain/entities/item.dart';
import '../../screens/receipt/receipt_params.dart';

// lưu tạm và sẽ xóa khi hoàn thành tạo đơn để gửi lên server
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerDataTemp = [];
//lưu trữ vị trí các rổ để gửi lên server
List<LocationServer> locationContainer = [];
//
List<String> shelfIds = [];
List<String> listemployeeId = [];
List<String> listitemId = [];
List<String> listItemName = [];
List<Item> listItem = [];

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ContainerUseCase containerUseCase;
  ReceiptUseCase receiptUseCase;
  ItemUseCase itemUseCase;
  ProductionEmployeeUseCase productionEmployeeUseCase;

  ReceiptBloc(this.receiptUseCase, this.itemUseCase,
      this.productionEmployeeUseCase, this.containerUseCase)
      : super(ReceiptInitialState()) {
    on<LoadAllDataEvent>(_onLoadData);
    on<RefershReceiptEvent>(_onRefresh);
    on<LoadReceiptHistoryEvent>(_onLoadHistory);
    on<LoadUnlocatedLotEvent>(_onLoadUnlocatedLot);
    on<LoadAllReceiptExported>(_onLoading);
    on<PostNewReceiptEvent>(_onPostReceipt);
    on<UpdateLocationReceiptEvent>(_onUpdateLocation);
    on<UpdateQuantityReceiptEvent>(_onUpdateQuantity);
  }
  Future<void> _onPostReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is PostNewReceiptEvent) {
      emit(ReceiptLoadingState(DateTime.now()));
      try {
        final request =
            await receiptUseCase.postNewReceipt(event.lots, event.receiptId);
        if (request.errorCode == "success") {
          print('success');

          // thêm container từ đơn qua để cập nhật vị trí
          // for (var element in goodsReceiptEntryConainerDataTemp) {
          //   locationContainer
          //       .add(LocationServer(element.lotId, '', null, null));
          // }
          goodsReceiptEntryConainerDataTemp.clear();

          emit(PostReceiptStateSuccess(DateTime.now(), request));
        } else {
          emit(PostReceiptStateFailure(request.errorMessage, DateTime.now()));
        }
      } catch (e) {
        print(e);
        emit(PostReceiptStateFailure(e.toString(), DateTime.now()));
        // state fail
      }
    }
  }

  Future<void> _onUpdateLocation(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is UpdateLocationReceiptEvent) {
        final request = await receiptUseCase.updateLocation(
            event.receiptId, event.lotId, event.shelfid, event.rowId, event.id);

        if (request == 200) {
          print('success');
          final receipts = await receiptUseCase.getUnlocatedLot();
          emit(LoadUnlocatedLotSuccess(receipts, DateTime.now()));
          // emit(UpdateLocationReceiptStateSuccess(DateTime.now()));
        } else {
          emit(UpdateLocationReceiptStateFailure(DateTime.now()));
        }
      }
    } catch (e) {
      emit(UpdateLocationReceiptStateFailure(DateTime.now()));
      // state fail
    }
  }

  Future<void> _onUpdateQuantity(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is UpdateQuantityReceiptEvent) {
        final request = await receiptUseCase.updateQuantity(
            event.receiptId, event.lotId, event.quantity);
        if (request == 200) {
          emit(UpdateQuantitySuccess(DateTime.now()));
        } else {
          emit(UpdateQuantityFail(DateTime.now()));
        }
      }
    } catch (e) {
      print(e);
      emit(UpdateQuantityFail(DateTime.now()));
      // state fail
    }
  }

  Future<void> _onLoadData(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadAllDataEvent) {
        listitemId.clear();
        listemployeeId.clear();
        listItemName.clear();
        listItem.clear();
        shelfIds.clear();
        final productOrErr = await itemUseCase.getAllItem();
        final employees = await productionEmployeeUseCase.getAllEmployee();
        final shelfs = await receiptUseCase.getShelfIds();
        shelfIds = shelfs;
        if (productOrErr.isNotEmpty) {
          for (int i = 0; i < productOrErr.length; i++) {
            listitemId.add(productOrErr[i].itemId);
            listItem.add(productOrErr[i]);
            listItemName.add(productOrErr[i].name);
          }
        }
        if (employees.isNotEmpty) {
          for (int i = 0; i < employees.length; i++) {
            listemployeeId.add(employees[i].employeeId);
          }
        }

        emit(ReceiptInitialState());
      }
    } catch (e) {
      print(e);
    }
  }

//---------------------------------------
  Future<void> _onCheck(ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is CheckContainerAvailableEvent) {
        final basketOrErr =
            await containerUseCase.getContainerById(event.containerId);
        if (basketOrErr.location != null && basketOrErr.item != null) {
          emit(CheckContainerStateFail(DateTime.now(), 'Lô đã được nhập kho'));
        } else {
          emit(CheckContainerStateSuccess(DateTime.now()));
        }
      }
    } catch (e) {
      emit(CheckContainerStateFail(DateTime.now(), 'Lô không xác định'));
    }
  }

  Future<void> _onLoading(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadAllReceiptExported) {
        final receipts = await receiptUseCase.getAllReceipt();
        emit(LoadReceiptExportingStateSuccess(DateTime.now(), receipts));
      }
    } catch (e) {
      emit(LoadReceiptExportingStateFail(DateTime.now()));
    }
  }
//---------------------------------------

  Future<void> _onLoadHistory(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadReceiptHistoryEvent) {
        final receipts = await receiptUseCase.getReceiptHistory(
            DateFormat('yyyy-MM-dd').format(event.startdate),
            DateFormat('yyyy-MM-dd').format(event.enddate));
        emit(HistoryStateLoadSuccess(DateTime.now(), receipts));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onLoadUnlocatedLot(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadUnlocatedLotEvent) {
        final receipts = await receiptUseCase.getUnlocatedLot();
        emit(LoadUnlocatedLotSuccess(receipts, DateTime.now()));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onRefresh(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is RefershReceiptEvent) {
        emit(RefershStateSuccess(DateTime.now()));
      }
    } catch (e) {}
  }
}
