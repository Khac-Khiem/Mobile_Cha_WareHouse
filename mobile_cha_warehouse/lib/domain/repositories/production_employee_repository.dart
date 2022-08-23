import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';

abstract class ProductionEmployeeRepository {
  Future<List<ProductionEmployee>> getAllEmployee();
}