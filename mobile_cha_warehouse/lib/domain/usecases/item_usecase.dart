import 'package:mobile_cha_warehouse/domain/entities/item.dart';
import 'package:mobile_cha_warehouse/domain/repositories/item_repository.dart';

class ItemUseCase {
  final ItemRepository itemRrepository;
  ItemUseCase(this.itemRrepository);
  Future<List<Item>> getAllItem() async {
    final item = itemRrepository.getAllItem();
    return item;
  }

  Future<Item> getItemById(String id) async {
    final item = itemRrepository.getItemById(id);
    return item;
  }
}
