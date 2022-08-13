import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/usecases/container_usecase.dart';
import 'package:mobile_cha_warehouse/domain/usecases/issue_usecase.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/check_info_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/check_info_state.dart';

class CheckInfoBloc extends Bloc<CheckInfoEvent, CheckInfoState> {
  ContainerUseCase containerUseCase;
  IssueUseCase issueUseCase;
  CheckInfoBloc(this.containerUseCase, this.issueUseCase)
      : super(CheckInfoStateLoading()) {
    on<CheckInfoEventRequested>(_onLoading);
   // on<AddContainerEvent>(_onAddContainer);
  }
  @override
  Future<void> _onLoading(
      CheckInfoEvent event, Emitter<CheckInfoState> emit) async {
    if (event is CheckInfoEventRequested) {
      emit(CheckInfoStateLoading());
      //Tất cả các lệnh dùng repository, đều phải có try catch để tránh lỗi crash
      try {
        final basketOrErr =
            await containerUseCase.getContainerById(event.basketID);
        print(basketOrErr);
        //Trả về view nguyên cái basket, view tự tách ra mà dùng
        emit(CheckInfoStateSuccess(basketOrErr, DateTime.now()));
      } catch (e) {
        print(e);
        emit(CheckInfoStateFailure()); // Viết vậy để truyền String vô thôi
      }
    }
  }
}
