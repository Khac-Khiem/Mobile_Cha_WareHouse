import 'package:equatable/equatable.dart';
import 'package:mobile_cha_warehouse/domain/entities/token.dart';

abstract class LoginState extends Equatable {}

class LoginStateFormatChecking extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;

  LoginStateFormatChecking(
    this.isPasswordErr,
    this.isUsernameErr,
  );
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr];
}

class LoginStateToggleShow extends LoginState {
  bool isShow;
  LoginStateToggleShow(this.isShow);
  @override
  List<Object> get props => [isShow];
}

class LoginStateInitial extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;
  bool isShow;
  LoginStateInitial(this.isUsernameErr, this.isPasswordErr, this.isShow);
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr, isShow];
}

class LoginStateLoadingRequest extends LoginState {
  DateTime timestamp;
  LoginStateLoadingRequest(this.timestamp,);
  @override
  List<Object> get props => [timestamp];
}

class LoginStateLoginSuccessful extends LoginState {
  DateTime timestamp;
 // LoginData loginData;
  LoginStateLoginSuccessful(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoginStateLoginFailure extends LoginState {
  DateTime timestamp;
//  ErrorPackage errorPackage;
  LoginStateLoginFailure(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
