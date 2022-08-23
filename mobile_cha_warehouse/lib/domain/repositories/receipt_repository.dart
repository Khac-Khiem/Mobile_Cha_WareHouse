
import '../../presentation/screens/receipt/receipt_params.dart';

abstract class ReceiptsRepo {
  
  Future<int> postNewReceiptRepo(List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId );
  Future<int> updateLocationRepo(
      String containerId, String shelfId, int rowId, int id);
}
