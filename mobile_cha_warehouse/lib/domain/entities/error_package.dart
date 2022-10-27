import 'package:equatable/equatable.dart';

class ErrorPackage extends Equatable {
  String errorCode;
  String errorMessage;
  
  ErrorPackage(this.errorCode, this.errorMessage, );

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage, errorCode];
}
