import 'package:mobile_cha_warehouse/datasource/service/production_employee_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/repositories/production_employee_repository.dart';

class ProductionEmployeeRepoImpl implements ProductionEmployeeRepository {
  ProductionService productionService;
  ProductionEmployeeRepoImpl(this.productionService);
  @override
  Future<List<ProductionEmployee>> getAllEmployee() {
    // TODO: implement getAllEmployee
    final employees = productionService.getAllEmployees();
    return employees;
  }
}
