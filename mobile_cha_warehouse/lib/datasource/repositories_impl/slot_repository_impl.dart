import 'package:mobile_cha_warehouse/datasource/service/slot_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/repositories/slot_repository.dart';

class SlotRepositoryImpl implements SlotRepository {
  SlotService slotService;
  SlotRepositoryImpl(this.slotService);

  @override
  Future<Cell> getCellByContainer(String id) {
    // TODO: implement getCellByContainer
    final cell = slotService.getCellById(id);
    return cell;
  }
}
