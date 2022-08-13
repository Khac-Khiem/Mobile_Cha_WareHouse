import 'package:mobile_cha_warehouse/datasource/models/stockcard_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/stockcard_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/domain/repositories/stockcard_repository.dart';

class StockCardRepositoryImpl implements StockCardRepo {
  StockCardService stockCardService;
  StockCardRepositoryImpl(this.stockCardService);

  @override
  Future<List<StockCardEntry>> getStockCards(String id, String startDate, String endDate) {
    // TODO: implement getStockCards
    final stockcard = stockCardService.getStockCardByItem(id, startDate, endDate);
    return stockcard;
  }
}
