import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';
import 'package:mobile_cha_warehouse/domain/repositories/inconsistency_container_repository.dart';

class InconsistencyContainerUseCase {
  final InconsistencyContainerRepository inconsistencyContainerRepository;
  InconsistencyContainerUseCase(this.inconsistencyContainerRepository);
  Future<List<ContainerInconsistency>> getInconsistencyContainers() async {
    final containerInconsistency =
        inconsistencyContainerRepository.getUnfixedInconsistency();
    return containerInconsistency;
  }

  Future reportInconsistency(String containerId, String goodsIssueId, DateTime timeStamp) async {
    inconsistencyContainerRepository.reportInconsistency(containerId, goodsIssueId, timeStamp );
  }
  Future patchFixInconsistency() async{
    
  }
}
