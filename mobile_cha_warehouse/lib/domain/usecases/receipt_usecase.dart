import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptUseCase {
  final ReceiptsRepo _receiptsRepo;
  ReceiptUseCase(this._receiptsRepo);
  // Future<List<GoodsReceipt>> getAllReceipts(String startDate) async {
  //   final goodsreceipts = await _receiptsRepo.getReceipts(startDate);
  //   return goodsreceipts;
  // }
  // Future<GoodsReceipt> getReceiptsById(String id) async {
  //   final goodsreceipts = await _receiptsRepo.getReceiptById(id);
  //   return goodsreceipts;
  // }
  //  Future<void> addContainerReceipt(String receiptId, GoodsReceiptEntryContainerData goodsIssueContainerData) async {
  //   final containerConfirm = await _receiptsRepo.addContainerReceipt(receiptId, goodsIssueContainerData);
  //   return containerConfirm;
  // }
  //  Future<void> confirmContainer(String receiptId) async {
  //   final confirm = await _receiptsRepo.confirmReceipt(receiptId);
  //   return confirm;
  // }
  Future postNewReceipt(
  List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId) async {
    final statusRequet = await _receiptsRepo.postNewReceiptRepo(goodsReceipt, receiptId);
    return statusRequet;
  }

  Future updateLocation(
      String containerId, String shelfId, int rowId, int id) async {
    final statusRequest =
        await _receiptsRepo.updateLocationRepo(containerId, shelfId, rowId, id);
    return statusRequest;
  }
}
