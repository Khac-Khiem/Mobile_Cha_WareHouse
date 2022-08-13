import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/usecases/item_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/stockcard_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/stockcard_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/stockcard_state.dart';

List<Item> allProductList = [];
List<String> allProductIdList = [];

class StockCardViewBloc extends Bloc<StockCardViewEvent, StockCardViewState> {
  StockCardsUseCase stockCardsUseCase;
  ItemUseCase itemUseCase;
  StockCardViewBloc(this.stockCardsUseCase, this.itemUseCase)
      : super(StockCardViewStateLoadingProduct()) {
    on<StockCardViewEventLoadAllProductID>(_onLoadID);
    on<StockCardViewEventSelectProductId>(_onSelectItemID);
    on<StockCardViewEventLoad>(_onLoadStockCard);
  }
  Future<void> _onLoadID(
      StockCardViewEvent event, Emitter<StockCardViewState> emit) async {
    if (event is StockCardViewEventLoadAllProductID) {
      emit(StockCardViewStateLoadingProduct());
      try {
        allProductIdList.clear();
        final productOrErr = await itemUseCase.getAllItem();
        print(productOrErr.toString());

        if (productOrErr.isNotEmpty) {
          // allProductIdList =
          //     allProductList.select((product, index) => product.id).toList();
          for (int i = 0; i < productOrErr.length; i++) {
            allProductIdList.add(productOrErr[i].itemId);
            allProductList.add(productOrErr[i]);
          }
          print(allProductIdList.toString());
          emit(StockCardViewStateLoadProductSuccess(DateTime.now()));
        } else {
          print(productOrErr.toString());
          //     yield StockCardViewStateLoadFailed(errorPackage: productOrErr);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _onSelectItemID(
      StockCardViewEvent event, Emitter<StockCardViewState> emit) async {
    if (event is StockCardViewEventSelectProductId) {
      try {
        for (int i = 0; i < allProductList.length; i++) {
          if (allProductList[i].itemId == event.productId) {
            emit(StockCardViewStateSelectedProductID(allProductList[i].name));
          }
        }
      } catch (e) {
        print(e);
        // yield StockCardViewStateLoadFailed(

      }
    }
  }

  Future<void> _onLoadStockCard(
      StockCardViewEvent event, Emitter<StockCardViewState> emit) async {
    if (event is StockCardViewEventLoad) {
      if (event.endDate.compareTo(event.startDate) != 1) {
        emit(StockCardViewStateLoadFailed());
      } else {
        emit(StockCardViewStateLoading());
        try {
          final stockCardOrErr = await stockCardsUseCase.getStockcards(
              event.productId,
              DateFormat('yyyy-MM-dd').format(event.startDate),
              DateFormat('yyyy-MM-dd').format(event.endDate));
          print(stockCardOrErr);
          emit(StockCardViewStateLoadSuccess(event.timestamp, stockCardOrErr));
        } catch (e) {
          print(e);
          emit(StockCardViewStateLoadFailed());
        }
      }
    }
  }
}
