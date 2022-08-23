import 'package:mobile_cha_warehouse/datasource/service/container_service.dart';
import 'package:mobile_cha_warehouse/datasource/service/inconsistency_container_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';
import 'package:mobile_cha_warehouse/domain/repositories/inconsistency_container_repository.dart';

class InconsistencyContainerRepoImpl
    implements InconsistencyContainerRepository {
  InconsistencyContainerService inconsistencyContainerService;
  InconsistencyContainerRepoImpl(this.inconsistencyContainerService);
  @override
  Future<List<ContainerInconsistency>> getUnfixedInconsistency() {
    // TODO: implement getUnfixedInconsistency
    throw UnimplementedError();
  }

  @override
  Future patchFixInconsistency(String basketId, DateTime timestamp,
      int newQuantity, double newMass, String note) {
    // TODO: implement patchFixInconsistency
    throw UnimplementedError();
  }

  @override
  Future<int> reportInconsistency(
      String containerId, int newQuantity, String note, DateTime timestamp) {
    // TODO: implement reportInconsistency
    final request = inconsistencyContainerService.reportInconsistencyContainer(
        containerId, newQuantity, note, timestamp);
    return request;
  }
}
