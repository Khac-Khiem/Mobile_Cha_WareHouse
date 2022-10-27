import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/error_package_model.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import '../../presentation/screens/receipt/receipt_params.dart';

String tokenId = '';

class ReceiptService {
  Future<ErrorPackage> postNewReceiptService(
      List<GoodsReceiptEntryContainerData> lots, String receiptId) async {
    List bodyJson = [];
    for (int i = 0; i < lots.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": lots[i].itemId,
        "lotId": lots[i].lotId,
        "quantity": double.parse(lots[i].actualQuantity.toString()),
        "date": DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 1)))
            .toString(),
        "location": {
          "shelfId": lots[i].location.shelfId,
          "row": lots[i].location.rowId,
          "column": lots[i].location.id
        }
        // "itemId": "i1",
        // "employeeId": "pkkhiem",
        // "containerId": "r3",
        // "quantity": 50.0,
        // "productionDate": "2022-08-10"
      };
      bodyJson.add(dimensionJson);
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
                // "containers": [
                //   {
                //     "itemId": "i1",
                //     "employeeId": "pkkhiem",
                //     "containerId": "r2",
                //     "quantity": 50.0,
                //     "productionDate": "2022-08-10"
                //   },
                // ]
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
      String containerId, String shelfId, int rowId, int id) async {
    final res = await http.patch(
        Uri.parse(Constants.baseUrl + 'api/containers/$containerId/location'),
        headers: {
          'Content-Type': 'application/json',
          //'Accept': '*/*',
          // 'Authorization': 'Bearer $token',
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
}
