import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_per_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_per_basket_state.dart';

import '../../../domain/entities/error_package.dart';
import '../../../domain/usecases/inconsistency_container_usecase.dart';

List<String> allItemId = [];

class EditPerBasketBloc extends Bloc<EditPerBasketEvent, EditPerBasketState> {
  InconsistencyContainerUseCase inconsistencyContainerUseCase;
  ItemUseCase itemUseCase;
  ContainerUseCase containerUseCase;
  IssueUseCase issueUseCase;
  EditPerBasketBloc(this.inconsistencyContainerUseCase, this.containerUseCase,
      this.itemUseCase, this.issueUseCase)
      : super(EditPerBasketStateInit()) {
    on<LoadAllItemIInventoryEvent>(_onLoadItem);
    on<CheckInfoInventoryEvent>(_onLoad);
    on<LoadLotInventoryEvent>(_onLoadLot);
    on<EditPerBasketEventEditClick>(_onEditClick);
  }
  Future<void> _onLoadLot(
      EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async {
    if (event is LoadLotInventoryEvent) {
      emit(EditPerBasketStateUploadLoading());
      try {
        final lots = await issueUseCase.getLotByItemId(event.itemId);
        emit(InventoryStateLoadLotSuccess(lots, DateTime.now()));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _onLoadItem(
      EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async {
    if (event is LoadAllItemIInventoryEvent) {
      emit(InventoryStateLoadingProduct());
      //Tất cả các lệnh dùng repository, đều phải có try catch để tránh lỗi crash
      try {
        allItemId.clear();
        final productOrErr = await itemUseCase.getAllItem();
        print(productOrErr.toString());

        if (productOrErr.isNotEmpty) {
          for (int i = 0; i < productOrErr.length; i++) {
            allItemId.add(productOrErr[i].itemId);
          }
          print(allItemId.toString());
        }
        emit(InventoryStateLoadProductSuccess(allItemId, DateTime.now()));
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _onLoad(
      EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async {
    if (event is CheckInfoInventoryEvent) {
      emit(EditPerBasketStateUploadLoading());
      //Tất cả các lệnh dùng repository, đều phải có try catch để tránh lỗi crash
      try {
        final basketOrErr =
            await containerUseCase.getContainerById(event.basketID);
        //Trả về view nguyên cái basket, view tự tách ra mà dùng
        emit(CheckInfoInventoryStateSuccess(basketOrErr, DateTime.now()));
      } catch (e) {
        emit(
            CheckInfoInventoryStateFailure()); // Viết vậy để truyền String vô thôi
      }
    }
  }

  Future<void> _onEditClick(
      EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async {
    emit(EditPerBasketStateUploadLoading());
    try {
      if (event is EditPerBasketEventEditClick) {
        final request = await inconsistencyContainerUseCase.reportInconsistency(
            event.containerId, event.note, event.newQuantity, event.timeStamp);
       // emit(EditPerBasketStateUploadSuccess(DateTime.now()));
        if (request == 200) {
          print('success');
          emit(EditPerBasketStateUploadSuccess(DateTime.now()));
        } else {
          print('thất bại');
          emit(EditPerBasketStateUploadFailed(
              ErrorPackage("Something went wrong", '',)));
        }
      }
    } catch (e) {
      // state fail
    }
  }
}
