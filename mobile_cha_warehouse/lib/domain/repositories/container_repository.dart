import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';

abstract class ContainRepo {
  Future getContainerById(String containerId);
  Future<ContainerData> updateContain(int plannedQuantity,
      DateTime productionDate, Item product, int actualQuantity);
  Future<ContainerData> updateActualQuantity(int actualQuantity);
  Future<ContainerData> updateShelfUnit(String shelfUnitId);
  Future<void> clear();
}

