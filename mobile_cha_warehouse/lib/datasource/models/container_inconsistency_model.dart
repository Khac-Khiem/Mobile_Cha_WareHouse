import 'package:mobile_cha_warehouse/datasource/models/warehouse_employee_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/warehouse_product_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

class ContainerInconsistencyModel extends ContainerInconsistency {
  ContainerInconsistencyModel(
      DateTime timestamp,
      String containerId,
      String shelfUnitId,
      String goodsIssuId,
      int currentQuantity,
      int newQuantity,
      String note,
      bool isFixed,
      WarehouseEmployeeModel reporter,
      ItemModel product)
      : super(timestamp, containerId, shelfUnitId, goodsIssuId, currentQuantity,
            newQuantity, note, isFixed, reporter, product);
}
