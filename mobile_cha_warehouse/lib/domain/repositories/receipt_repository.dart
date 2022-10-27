
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';

import '../../presentation/screens/receipt/receipt_params.dart';

abstract class ReceiptsRepo {
  
  Future<ErrorPackage> postNewReceiptRepo(List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId );
  Future<int> updateLocationRepo(
      String containerId, String shelfId, int rowId, int id);
}
