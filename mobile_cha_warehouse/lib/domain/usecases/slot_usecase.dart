import 'package:mobile_cha_warehouse/domain/entities/cell_data.dart';
import 'package:mobile_cha_warehouse/domain/entities/storage_slot.dart';
import 'package:mobile_cha_warehouse/domain/repositories/slot_repository.dart';

class SlotUseCase {
  SlotRepository _slotRepository;
  SlotUseCase(this._slotRepository);
  Future<Cell> getCellById(String id) async {
    final cell = _slotRepository.getCellByContainer(id);
    return cell;
  }
}
