import 'package:mobile_cha_warehouse/domain/entities/container_inconsistency.dart';

abstract class InconsistencyContainerRepository {
  Future<int> reportInconsistency(
      String containerId, int newQuantity,String note, DateTime timestamp);
  Future<List<ContainerInconsistency>> getUnfixedInconsistency();
  Future patchFixInconsistency(String basketId, DateTime timestamp,
      int newQuantity, double newMass, String note);
}
