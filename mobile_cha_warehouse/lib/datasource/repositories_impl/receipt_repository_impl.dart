import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/repositories/receipt_repository.dart';
import 'package:mobile_cha_warehouse/presentation/screens/receipt/receipt_params.dart';

class ReceiptRepositoryImpl implements ReceiptsRepo {
  ReceiptService receiptService;
  ReceiptRepositoryImpl(this.receiptService);

  @override
  Future<ErrorPackage> postNewReceiptRepo(List<GoodsReceiptEntryContainerData> goodsReceipt, String receiptId) {
    // TODO: implement postNewReceiptRepo
    final statusRequest = receiptService.postNewReceiptService(goodsReceipt, receiptId);
    return statusRequest;
  }

  @override
  Future<int> updateLocationRepo(
      String containerId, String shelfId, int rowId, int id) {
    // TODO: implement updateLocationRepo
    final statusRequest =
        receiptService.updateLocationService(containerId, shelfId, rowId, id);
    return statusRequest;
  }
}
