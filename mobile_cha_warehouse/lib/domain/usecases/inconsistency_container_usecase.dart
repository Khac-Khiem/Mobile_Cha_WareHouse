import 'package:mobile_cha_warehouse/domain/repositories/inconsistency_container_repository.dart';

class InconsistencyContainerUseCase {
  final InconsistencyContainerRepository inconsistencyContainerRepository;
  InconsistencyContainerUseCase(this.inconsistencyContainerRepository);
  // Future<List<ContainerInconsistency>> getInconsistencyContainers() async {
  //   final containerInconsistency =
  //       inconsistencyContainerRepository.getUnfixedInconsistency();
  //   return containerInconsistency;
  // }

  Future reportInconsistency(String containerId,String note, int newQuantity, DateTime timeStamp) async {
    inconsistencyContainerRepository.reportInconsistency(containerId, newQuantity,note, timeStamp );
  }
}
