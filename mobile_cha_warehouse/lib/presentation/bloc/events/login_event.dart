import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginEventChecking extends LoginEvent {
  String userName;
  String passWord;
  LoginEventChecking(this.passWord, this.userName);
  @override
  List<Object> get props => [userName, passWord];
}

class LoginEventToggleShow extends LoginEvent {
  bool isShow;
  LoginEventToggleShow(this.isShow);
  @override
  List<Object> get props => [isShow];
}

class LoginEventLoginClicked extends LoginEvent {
  String username, password;
  DateTime timestamp;
  LoginEventLoginClicked(this.username, this.password, this.timestamp);
  @override
  List<Object> get props => [username, password, timestamp];
}

class LoginEventFetchToken extends LoginEvent {
  DateTime timestamp;
  Uri responseUrl;
  LoginEventFetchToken(this.responseUrl, this.timestamp);
  @override
  // TODO: implement props
  List<Object?> get props => [timestamp];
}
