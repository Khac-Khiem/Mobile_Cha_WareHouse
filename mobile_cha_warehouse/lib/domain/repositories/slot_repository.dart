import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';

abstract class SlotRepository {
  Future<Cell> getCellByContainer(String id);
}
