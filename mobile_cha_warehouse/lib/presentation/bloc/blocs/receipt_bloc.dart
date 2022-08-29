import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/production_employee_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import '../../screens/receipt/receipt_params.dart';

// lưu tạm và sẽ xóa khi hoàn thành tạo đơn để gửi lên server
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerDataTemp = [];
//lưu trữ tất cả các rổ để add vị trí + gộp chung nhiều đơn vào 1 list
//List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerData = [];
//lưu trữ vị trí các rổ để gửi lên server
List<LocationServer> locationContainer = [];
//
List<String> listemployeeId = [];
List<String> listitemId = [];

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
    on<CheckContainerAvailableEvent>(_onCheck);
    on<LoadAllContainerExporting>(_onLoading);
    on<PostNewReceiptEvent>(_onPostReceipt);
    on<UpdateLocationReceiptEvent>(_onUpdateLocation);
  }
  Future<void> _onPostReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is PostNewReceiptEvent) {
      //  emit(ReceiptLoadingState(DateTime.now()));
      try {
        final request = await receiptUseCase.postNewReceipt(
            event.goodsReceiptEntryContainers, event.receiptId);
        if (request == 200) {
          print('success');

          // thêm container từ đơn qua để cập nhật vị trí
          for (var element in goodsReceiptEntryConainerDataTemp) {
            locationContainer
                .add(LocationServer(element.containerId, '', null, null));
          }
          goodsReceiptEntryConainerDataTemp.clear();

          emit(PostReceiptStateSuccess(DateTime.now(), request));
        } else {
          emit(PostReceiptStateFailure(request.toString(), DateTime.now()));
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
            event.containerId, event.shelfid, event.rowId, event.id);

        if (request == 200) {
          print('success');
          emit(UpdateLocationReceiptStateSuccess(DateTime.now()));
        } else {
          emit(UpdateLocationReceiptStateFailure(DateTime.now()));
        }
      }
    } catch (e) {
      emit(UpdateLocationReceiptStateFailure(DateTime.now()));
      // state fail
    }
  }

  Future<void> _onLoadData(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadAllDataEvent) {
        listitemId = [];
        listemployeeId = [];
        final productOrErr = await itemUseCase.getAllItem();
        final employees = await productionEmployeeUseCase.getAllEmployee();

        if (productOrErr.isNotEmpty) {
          for (int i = 0; i < productOrErr.length; i++) {
            listitemId.add(productOrErr[i].itemId);
          }
        }
        if (employees.isNotEmpty) {
          for (int i = 0; i < employees.length; i++) {
            listemployeeId.add(employees[i].employeeId);
          }
        }
        print(listitemId);
        print(listemployeeId);
        emit(ReceiptInitialState());
      }
    } catch (e) {}
  }

  Future<void> _onCheck(ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is CheckContainerAvailableEvent) {
        final basketOrErr =
            await containerUseCase.getContainerById(event.containerId);
        if (basketOrErr.location != null && basketOrErr.item != null) {
          emit(CheckContainerStateFail(DateTime.now(), 'Rổ đã được nhập kho'));
        } else {
          emit(CheckContainerStateSuccess(DateTime.now()));
        }
      }
    } catch (e) {
      emit(CheckContainerStateFail(DateTime.now(), 'Rổ không xác định'));
    }
  }

  Future<void> _onLoading(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    emit(ReceiptLoadingState(DateTime.now()));
    try {
      if (event is LoadAllContainerExporting) {
        final basketOrErr = await containerUseCase.getExportingContainer();
        if (basketOrErr.isEmpty) {
          emit(LoadContainerExportingStateSuccess(DateTime.now(), []));
        } else {
          emit(LoadContainerExportingStateSuccess(DateTime.now(), basketOrErr));
        }
      }
    } catch (e) {
      emit(LoadContainerExportingStateFail(DateTime.now()));
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
