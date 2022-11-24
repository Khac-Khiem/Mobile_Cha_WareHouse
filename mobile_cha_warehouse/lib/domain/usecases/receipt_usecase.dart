import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptUseCase {
  final ReceiptsRepo _receiptsRepo;
  ReceiptUseCase(this._receiptsRepo);
  Future<ErrorPackage> postNewReceipt(
      List<GoodsReceiptEntryContainerData> goodsReceipt,
      String receiptId) async {
    final statusRequest =
        await _receiptsRepo.postNewReceiptRepo(goodsReceipt, receiptId);
    return statusRequest;
  }

  Future updateLocation(
      String receiptId, String lotId, String shelfId, int rowId, int id) async {
    final statusRequest =
        await _receiptsRepo.updateLocationRepo(receiptId, lotId, shelfId, rowId, id);
    return statusRequest;
  }

  Future updateQuantity(
      String receiptId, String lotId, dynamic quantity) async {
    final statusRequest =
        await _receiptsRepo.updateQuantityRepo(receiptId, lotId, quantity);
    return statusRequest;
  }

  Future<GoodsReceiptData> getReceiptHistory(
      String startDate, String endDate) async {
    final receipt = await _receiptsRepo.getReceiptHistory(startDate, endDate);
    return receipt;
  }
  Future<List<String>> getShelfIds (
    ) async {
    final shelfIds = await _receiptsRepo.getShelfIds();
    return shelfIds;
  }
  Future<List<GoodsReceiptsModel>> getAllReceipt (
    ) async {
    final receipts  = await _receiptsRepo.getAllReceipt();
    return receipts;
  }
   Future<List<UnlocatedLotReceipt>> getUnlocatedLot (
    ) async {
    final receipts  = await _receiptsRepo.getUnlocatedLot();
    return receipts;
  }
}
