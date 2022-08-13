import 'package:mobile_cha_warehouse/domain/entities/stock_card.dart';
import 'package:mobile_cha_warehouse/domain/repositories/stockcard_repository.dart';

class StockCardsUseCase {
  final StockCardRepo _stockCardRepo;
  StockCardsUseCase(this._stockCardRepo);
  Future<List<StockCardEntry>> getStockcards(String id, String startDate, String endDate) async {
    final stockCard = await _stockCardRepo.getStockCards(id, startDate, endDate);
    return stockCard;
  }
}
