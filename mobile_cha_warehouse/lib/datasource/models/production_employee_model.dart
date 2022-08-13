import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';

class ProductionEmployeeModel extends ProductionEmployee{
  ProductionEmployeeModel(String employeeId, String firstName, String lastName, String dateOfBirth) : super(employeeId, firstName, lastName, dateOfBirth);
factory ProductionEmployeeModel.fromJson(Map<String, dynamic> json) {
    return ProductionEmployeeModel(
      json["employeeId"],
      json["firstName"],
      json["lastName"],
      json["dateOfBirth"],
    );
  }
}