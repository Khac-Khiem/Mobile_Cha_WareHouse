import 'package:equatable/equatable.dart';

class ErrorPackage extends Equatable {
  String errorCode;
  String message;
  String detail;
  ErrorPackage(this.errorCode, this.message, this.detail);

  @override
  // TODO: implement props
  List<Object?> get props => [message, errorCode, detail];
}
