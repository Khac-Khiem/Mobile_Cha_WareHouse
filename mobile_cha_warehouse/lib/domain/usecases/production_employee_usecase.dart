import 'package:mobile_cha_warehouse/domain/entities/production_employee.dart';
import 'package:mobile_cha_warehouse/domain/repositories/production_employee_repository.dart';

class ProductionEmployeeUseCase {
  final ProductionEmployeeRepository productionEmployeeRepository;
  ProductionEmployeeUseCase(this.productionEmployeeRepository);
  Future<List<ProductionEmployee>> getAllEmployee() async {
    final employee = productionEmployeeRepository.getAllEmployee();
    return employee;
  }
}
