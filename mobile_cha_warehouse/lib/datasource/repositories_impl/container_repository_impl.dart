import 'package:mobile_cha_warehouse/datasource/service/container_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/repositories/container_repository.dart';

class ContainerRepoImpl implements ContainRepo {
  ContainerService containerService;
  ContainerRepoImpl(this.containerService);
  @override
  Future getContainerById(String id) {
    final container = containerService.getContainerLocation(id);
    return container;
  }

  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<ContainerData> updateActualQuantity(int actualQuantity) {
    // TODO: implement updateActualQuantity
    throw UnimplementedError();
  }

  @override
  Future<ContainerData> updateContain(int plannedQuantity,
      DateTime productionDate, Item product, int actualQuantity) {
    // TODO: implement updateContain
    throw UnimplementedError();
  }

  @override
  Future<ContainerData> updateShelfUnit(String shelfUnitId) {
    // TODO: implement updateShelfUnit
    throw UnimplementedError();
  }
}
