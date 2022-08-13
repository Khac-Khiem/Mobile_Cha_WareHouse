import 'package:equatable/equatable.dart';

class ProductionEmployee extends Equatable {
  String employeeId;
  String firstName;
  String lastName;
  String dateOfBirth;
  ProductionEmployee(
      this.employeeId, this.firstName, this.lastName, this.dateOfBirth);
  @override
  // TODO: implement props
  List<Object?> get props => [employeeId, firstName, lastName, dateOfBirth];
}
