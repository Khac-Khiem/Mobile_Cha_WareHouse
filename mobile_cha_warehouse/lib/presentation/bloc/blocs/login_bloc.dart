import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/domain/entities/token.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/events/login_event.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInitial(false, false, true)) {
    on((LoginEventChecking event, emit) => LoginStateFormatChecking(
        event.passWord.length < Constants.minLengthPassWord,
        event.userName.length < Constants.minLengthUserName));
   // on<LoginEventLoginClicked>(_onLogin);
    on((LoginEventToggleShow event, emit) =>
        LoginStateToggleShow(!event.isShow));
  }
  // Future<LoginData> _onLogin(){}
}
