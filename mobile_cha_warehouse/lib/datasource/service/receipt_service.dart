import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import '../../presentation/screens/receipt/receipt_params.dart';

String token = '';

class ReceiptService {
  List bodyJson = [];
  Future<int> postNewReceiptService(
      List<GoodsReceiptEntryContainerData> goodsReceiptEntryContainerData,
      String receiptId) async {
    for (int i = 0; i < goodsReceiptEntryContainerData.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": goodsReceiptEntryContainerData[i].itemId,
        "employeeId": goodsReceiptEntryContainerData[i].employeeId,
        "containerId": goodsReceiptEntryContainerData[i].containerId,
        "quantity": double.parse(
            goodsReceiptEntryContainerData[i].actualQuantity.toString()),
        "productionDate": DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(Duration(days: 1)))
            .toString()
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
              //  'Accept': '*/*',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(
              <String, dynamic>{
                "goodsReceiptId": receiptId,
                "timestamp": DateFormat('yyyy-MM-ddThh:mm:ss')
                    .format(DateTime.now())
                    .toString(),
                "containers": bodyJson
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
    return res.statusCode;
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
