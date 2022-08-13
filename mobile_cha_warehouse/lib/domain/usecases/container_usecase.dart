import 'package:mobile_cha_warehouse/domain/entities/container.dart';
import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/repositories/container_repository.dart';

class ContainerUseCase {
  final ContainRepo _updateContainRepo;

  ContainerUseCase(this._updateContainRepo);
  Future<ContainerData> getContainerById(String id) async {
    final container = await _updateContainRepo.getContainerById(id);
    return container;
  }

  Future<ContainerData> updateActualQuantity(int actualQuantity) async {
    final container =
        await _updateContainRepo.updateActualQuantity(actualQuantity);
    return container;
  }

  Future<ContainerData> updateContain(int a, int b, DateTime c, Item d) async {
    final container = await _updateContainRepo.updateContain(a, c, d, b);
    return container;
  }

  Future<ContainerData> updateShelfUnit(String a) async {
    final container = _updateContainRepo.updateShelfUnit(a);
    return container;
  }

  Future<void> clearContainer() async {
    final container = _updateContainRepo.clear();
  }
}
