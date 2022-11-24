import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/error_package_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/goods_receipts_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import '../../domain/entities/goods_receipt.dart';
import '../../presentation/screens/receipt/receipt_params.dart';

String tokenId = '';

class ReceiptService {
  Future<ErrorPackage> postNewReceiptService(
      List<GoodsReceiptEntryContainerData> lots, String receiptId) async {
    List bodyJson = [];
    for (int i = 0; i < lots.length; i++) {
      if (lots[i].unit == "cái") {
        Map<String, dynamic> dimensionJson = {
          "itemId": lots[i].itemId,
          "lotId": lots[i].lotId,
          "quantity": double.parse(lots[i].actualQuantity.toString()),
          "date": DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 1)))
              .toString(),
          "productionEmployeeId": lots[i].productionEmployeeId
         
        };
        bodyJson.add(dimensionJson);
      } else {
        Map<String, dynamic> dimensionJson = {
          "itemId": lots[i].itemId,
          "lotId": lots[i].lotId,
          "quantity": double.parse(lots[i].actualMass.toString()),
          "date": DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 1)))
              .toString(),
          "productionEmployeeId": lots[i].productionEmployeeId
         
        };
        bodyJson.add(dimensionJson);
      }
    }
    final res =
        await http.post(Uri.parse(Constants.baseUrl + 'api/goodsreceipts/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId',
            },
            body: jsonEncode(
              <String, dynamic>{
                "goodsReceiptId": receiptId,
                "timestamp": DateFormat('yyyy-MM-ddThh:mm:ss')
                    .format(DateTime.now())
                    .toString(),
                "lots": bodyJson
              },
            ));
    if (res.statusCode == 200) {
      return ErrorPackage("success", "success");
    } else {
      dynamic body = jsonDecode(res.body);
      ErrorPackage error = ErrorPackageModel.fromJson(body);
      return error;
    }
  }

  Future<int> updateLocationService(
      String receiptId, String lotId, String shelfId, int rowId, int id) async {
    final res = await http.patch(
        Uri.parse(Constants.baseUrl +
            '/api/goodsreceipts/$receiptId/lots/$lotId/location'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $tokenId',
        },
        body: jsonEncode(
          <String, dynamic>{
            "shelfId": shelfId, "row": rowId, "column": id
            //  "shelfId": "A", "row": 1, "column": 3
          },
        ));
    print(res.statusCode);
    return res.statusCode;
  }

  Future<int> updateQuantityService(
      String receiptId, String lotId, dynamic quantity) async {
    final res = await http.patch(
        Uri.parse(Constants.baseUrl +
            '/api/goodsreceipts/$receiptId/lots/$lotId/quantity'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $tokenId',
        },
        body: jsonEncode(
          <String, dynamic>{"quantity": double.parse(quantity)},
        ));

    print(res.statusCode);
    return res.statusCode;
  }

  Future<GoodsReceiptDataModel> getReceiptHistory(
      String startDate, String endDate) async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl +
          '/api/goodsreceipts/?Page=1&ItemsPerPage=10&StartTime=$startDate&EndTime=$endDate'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $tokenId',
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      dynamic body = jsonDecode(res.body);
      GoodsReceiptDataModel stockcard = GoodsReceiptDataModel.fromJson(body);
      // .map(
      //   (dynamic item) => GoodsReceiptDataModel.fromJson(item),
      // )
      // .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<String>> getAllShelf() async {
    final res =
        await http.get(Uri.parse(Constants.baseUrl + '/api/shelves/id'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      print(body.toString());
      List<String> shelfs = body.map((e) => e.toString()).toList();

      return shelfs;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<GoodsReceiptsModel>> getAllReceipt() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + '/api/goodsreceipts/pending'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId',
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      List<dynamic> body = jsonDecode(res.body);
      List<GoodsReceiptsModel> receipts = body
          .map(
            (dynamic item) => GoodsReceiptsModel.fromJson(item),
          )
          .toList();

      return receipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<UnlocatedLotReceiptModel>> getUnlocatedLot() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + '/api/goodsreceipts/lots/unlocated'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId',
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      List<dynamic> body = jsonDecode(res.body);
      List<UnlocatedLotReceiptModel> receipts = body
          .map(
            (dynamic item) => UnlocatedLotReceiptModel.fromJson(item),
          )
          .toList();

      return receipts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
