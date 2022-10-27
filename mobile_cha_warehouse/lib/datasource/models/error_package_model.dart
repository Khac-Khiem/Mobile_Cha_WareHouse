import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';

class ErrorPackageModel extends ErrorPackage{
  ErrorPackageModel(String errorCode, String message) : super(errorCode, message);
  factory ErrorPackageModel.fromJson(Map<String, dynamic> json) {
    return ErrorPackageModel(
      json["errorCode"],
      json["errorMessage"],
      
    );
  }
}