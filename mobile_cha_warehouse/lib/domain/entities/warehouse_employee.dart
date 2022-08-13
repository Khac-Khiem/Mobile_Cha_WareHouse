import 'package:equatable/equatable.dart';

class WarehouseEmployee extends Equatable {
  String employeeId;
  String firstName;
  String lastName;
  String dateOfBirth;
  WarehouseEmployee(
      this.employeeId, this.firstName, this.lastName, this.dateOfBirth);
  @override
  // TODO: implement props
  List<Object?> get props => [employeeId, firstName, lastName, dateOfBirth];
}
