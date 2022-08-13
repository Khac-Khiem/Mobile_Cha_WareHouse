import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/usecases/receipt_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/receipt_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/receipt_state.dart';
import '../../screens/receipt/receipt_params.dart';

// lưu tạm và sẽ xóa khi hoàn thành tạo đơn để gửi lên server
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerDataTemp = [];
//lưu trữ tất cả các rổ để add vị trí + gộp chung nhiều đơn vào 1 list
List<GoodsReceiptEntryContainerData> goodsReceiptEntryConainerData = [];
//lưu trữ vị trí các rổ để gửi lên server
List<LocationServer> locationContainer = [];

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptUseCase receiptUseCase;

  ReceiptBloc(this.receiptUseCase) : super(ReceiptInitialState()) {
    on<PostNewReceiptEvent>(_onPostReceipt);
    on<UpdateLocationReceiptEvent>(_onUpdateLocation);
  }
  Future<void> _onPostReceipt(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is PostNewReceiptEvent) {
      emit(ReceiptInitialState());
      try {
        final request = await receiptUseCase
            .postNewReceipt(event.goodsReceiptEntryContainers, event.receiptId);
        emit(PostReceiptStateSuccess(DateTime.now(), request));
      } catch (e) {
        emit(PostReceiptStateFailure(DateTime.now()));
        // state fail
      }
    }
  }

  Future<void> _onUpdateLocation(
      ReceiptEvent event, Emitter<ReceiptState> emit) async {
    if (event is UpdateLocationReceiptEvent) {
      emit(ReceiptInitialState());
      try {
        final request = await receiptUseCase.updateLocation(
            event.containerId, event.shelfid, event.rowId, event.id);
        emit(UpdateLocationReceiptStateSuccess(DateTime.now()));
      } catch (e) {
        emit(UpdateLocationReceiptStateFailure(DateTime.now()));
        // state fail
      }
    }
  }
}
