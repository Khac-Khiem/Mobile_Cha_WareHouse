import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/edit_per_basket_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/edit_per_basket_state.dart';

import '../../../domain/entities/error_package.dart';
import '../../../domain/usecases/inconsistency_container_usecase.dart';

class EditPerBasketBloc extends Bloc<EditPerBasketEvent, EditPerBasketState> {
  InconsistencyContainerUseCase inconsistencyContainerUseCase;
  ContainerUseCase containerUseCase;
  EditPerBasketBloc(this.inconsistencyContainerUseCase, this.containerUseCase)
      : super(EditPerBasketStateInit()) {
    // on<EditPerBasketEventEditMass>(_onEditMass);
    // on<EditPerBasketEventEditQuantity>(_onEditQuantity);
    on<CheckInfoInventoryEvent>(_onLoad);

    on<EditPerBasketEventEditClick>(_onEditClick);
  }
  // Stream<void> _onEditMass(
  //     EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async* {
  //   if (event is EditPerBasketEventEditMass) {
  //     yield EditPerBasketStateRefresh(
  //         mass: double.parse(event.massText), quantity: 0, note: "");
  //     try {
  //       double _mass = double.parse(event.massText);
  //       final productError = await itemUseCase.getItemById(event.productId);
  //       int ppkg = productError.piecesPerKilogram; //piece per kilogram
  //       int _quantity = (_mass * ppkg).toInt();
  //       String decreaseOrIcrease =
  //           event.currentQuantity > _quantity ? "giảm" : "tăng";
  //       // String _note = productOrErr.unitOfMeasurement == 0
  //       //     ? "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs()} cái"
  //       //     : "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs() / ppkg} kg";
  //       String _note =
  //           "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs() / ppkg}";
  //       yield EditPerBasketStateRefresh(
  //           mass: _mass, quantity: _quantity, note: _note);
  //     } on SocketException {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("SocketException", "", ""));
  //     } on FormatException {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("FormatException", event.massText, ""));
  //     } catch (e) {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("Something went wrong", '$e', ""));
  //     }
  //   }
  // }

  // Stream<void> _onEditQuantity(
  //     EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async* {
  //   if (event is EditPerBasketEventEditQuantity) {
  //     yield EditPerBasketStateRefresh(
  //         mass: double.parse(event.quantityText), quantity: 0, note: "");
  //     try {
  //       double _mass = double.parse(event.quantityText);
  //       final productError = await itemUseCase.getItemById(event.productId);
  //       int ppkg = productError.piecesPerKilogram; //piece per kilogram
  //       int _quantity = (_mass * ppkg).toInt();
  //       String decreaseOrIcrease =
  //           event.currentQuantity > _quantity ? "giảm" : "tăng";
  //       // String _note = productOrErr.unitOfMeasurement == 0
  //       //     ? "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs()} cái"
  //       //     : "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs() / ppkg} kg";
  //       String _note =
  //           "Điều chỉnh rổ sai $decreaseOrIcrease ${(event.currentQuantity - _quantity).abs() / ppkg}";
  //       yield EditPerBasketStateRefresh(
  //           mass: _mass, quantity: _quantity, note: _note);
  //     } on SocketException {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("SocketException", "", ""));
  //     } on FormatException {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("FormatException", event.quantityText, ""));
  //     } catch (e) {
  //       yield EditPerBasketStateRefreshFailed(
  //           ErrorPackage("Something went wrong", '$e', ""));
  //     }
  //   }
  // }
  Future<void> _onLoad(
      EditPerBasketEvent event, Emitter<EditPerBasketState> emit) async {
    if (event is CheckInfoInventoryEvent) {
      emit(EditPerBasketStateUploadLoading());
      //Tất cả các lệnh dùng repository, đều phải có try catch để tránh lỗi crash
      try {
        final basketOrErr =
            await containerUseCase.getContainerById(event.basketID);
        print(basketOrErr);
        //Trả về view nguyên cái basket, view tự tách ra mà dùng
        emit(CheckInfoInventoryStateSuccess(basketOrErr, DateTime.now()));
      } catch (e) {
        print(e);
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
        emit(EditPerBasketStateUploadSuccess(DateTime.now()));
        print(request);
        // if (request == 200) {
        //   print('success');
        //   emit(EditPerBasketStateUploadSuccess(DateTime.now()));
        // } else {
        //   print('thất bại');
        //   emit(EditPerBasketStateUploadFailed(
        //       ErrorPackage("Something went wrong", '', "")));
        // }
      }
    } catch (e) {
      emit(EditPerBasketStateUploadFailed(
          ErrorPackage("Something went wrong", '', "")));
      // state fail
    }
  }
}
