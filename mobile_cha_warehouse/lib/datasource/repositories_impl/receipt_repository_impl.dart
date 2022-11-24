import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptRepositoryImpl implements ReceiptsRepo {
  ReceiptService receiptService;
  ReceiptRepositoryImpl(this.receiptService);

  @override
  Future<ErrorPackage> postNewReceiptRepo(
      List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId) {
    // TODO: implement postNewReceiptRepo
    final statusRequest =
        receiptService.postNewReceiptService(goodsReceipt, receiptId);
    return statusRequest;
  }

  @override
  Future<int> updateLocationRepo(
      String receiptId, String lotId, String shelfId, int rowId, int id) {
    // TODO: implement updateLocationRepo
    final statusRequest = receiptService.updateLocationService(
        receiptId, lotId, shelfId, rowId, id);
    return statusRequest;
  }

  @override
  Future<GoodsReceiptData> getReceiptHistory(String startDate, String endDate) {
    // TODO: implement getReceiptHistory
    final receipt = receiptService.getReceiptHistory(startDate, endDate);
    return receipt;
  }

  @override
  Future<List<String>> getShelfIds() {
    // TODO: implement getShelfIds
    final shelfs = receiptService.getAllShelf();
    return shelfs;
  }

  @override
  Future<List<GoodsReceiptsModel>> getAllReceipt() {
    // TODO: implement getAllReceipt
    final receipts = receiptService.getAllReceipt();
    return receipts;
  }

  @override
  Future<List<UnlocatedLotReceipt>> getUnlocatedLot() {
    // TODO: implement getUnlocatedLot
    final receipts = receiptService.getUnlocatedLot();
    return receipts;
  }

  @override
  Future<int> updateQuantityRepo(String receiptId, String lotId, quantity) {
    // TODO: implement updateQuantityRepo
    final statusRequest =
        receiptService.updateQuantityService(receiptId, lotId, quantity);
    return statusRequest;
  }
}
