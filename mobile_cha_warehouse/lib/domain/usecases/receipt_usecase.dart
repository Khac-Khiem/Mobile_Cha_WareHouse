import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptUseCase {
  final ReceiptsRepo _receiptsRepo;
  ReceiptUseCase(this._receiptsRepo);
  Future postNewReceipt(
  List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId) async {
    final statusRequest = await _receiptsRepo.postNewReceiptRepo(goodsReceipt, receiptId);
    return statusRequest;
  }

  Future updateLocation(
      String containerId, String shelfId, int rowId, int id) async {
    final statusRequest =
        await _receiptsRepo.updateLocationRepo(containerId, shelfId, rowId, id);
    return statusRequest;
  }
}
