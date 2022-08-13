import 'package:mobile_cha_warehouse/datasource/service/container_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';
import 'package:mobile_cha_warehouse/domain/repositories/inconsistency_container_repository.dart';

class InconsistencyContainerRepoImpl
    implements InconsistencyContainerRepository {
  ContainerService containerService;
  InconsistencyContainerRepoImpl(this.containerService);
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
  Future reportInconsistency(
      String containerId, String goodsIssueId, DateTime timestamp) {
    // TODO: implement reportInconsistency
    throw UnimplementedError();
  }
}
