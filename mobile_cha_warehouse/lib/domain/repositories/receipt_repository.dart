import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';

import '../../presentation/screens/receipt/receipt_params.dart';

abstract class ReceiptsRepo {
  Future<ErrorPackage> postNewReceiptRepo(
      List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId);
  Future<int> updateLocationRepo(
      String receiptId , String lotId, String shelfId, int rowId, int id);
  Future<int> updateQuantityRepo(
      String receiptId , String lotId, dynamic quantity);
  Future<GoodsReceiptData> getReceiptHistory(String startDate, String endDate);
  Future<List<String>> getShelfIds();
  Future<List<GoodsReceiptsModel>> getAllReceipt();
  Future<List<UnlocatedLotReceipt>> getUnlocatedLot();
}
