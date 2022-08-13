import 'package:mobile_cha_warehouse/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItem();
  Future<Item> getItemById(String id);
}
