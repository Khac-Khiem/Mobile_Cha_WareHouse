import 'package:mobile_cha_warehouse/domain/entities/goods_receipt.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/issue_bloc.dart';
import 'package:mobile_cha_warehouse/presentation/bloc/blocs/receipt_bloc.dart';

import '../../presentation/screens/receipt/receipt_params.dart';

abstract class ReceiptsRepo {
  // Future<List<GoodsReceipt>> getReceipts(String startDate);
  // Future<GoodsReceipt> getReceiptById(String id);
  // Future<void> addContainerReceipt(
  //     String receiptId, GoodsReceiptEntryContainerData goodsIssueData);
  // Future<void> confirmReceipt(String receiptId);
  Future postNewReceiptRepo(List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId );
  Future updateLocationRepo(
      String containerId, String shelfId, int rowId, int id);
}
