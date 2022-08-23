import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import '../../presentation/screens/receipt/receipt_params.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkU0OUZBQkNEMjRGNkE5M0IxODdERUVBMDRGNDQ5RTI3IiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjA4MjIxMDE0MTkuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NjEyMjY4NDUsImlhdCI6MTY2MTIyNjg0NSwiZXhwIjoxNjYxMjU1NjQ1LCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjA4MjIxMDE0MTkuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNTIwY2FjM2QtZDUzMS00ZDQxLTY4MTgtMDhkYTgzZWUyMWYyIiwiYXV0aF90aW1lIjoxNjYxMjI2ODQyLCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiWEFHWERYSzRPVlIzQVZHSzVTQ1ZFSlgzTEVaMkVaUE8iLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJwa2toaWVtIiwibmFtZSI6InBra2hpZW0iLCJzaWQiOiI0NkFDOEJFODFFN0U3NjA1NjIyMzk2OEU3ODBFNTMyOCIsImp0aSI6IjhDQjI2QUVGRUVEMDA1NUJBMzE0OUQ4MDI1MUNCNDUyIn0.f_Mtw-3nKBiUS8MeUlexQx3Mw2pAaa9w2OtwlbSQXicSu1HD4ZHNr9yetM5rBK6-78f00FlRjeqpeiybdTz08FIsXBQL_vVtZ-wcvooc7BVY8bauWGGull9k0CkOlrfAv6UqH_PcO823SVFK6YYvD0d6rVg7miqIvvc3uXlGOwFeeXWYqcXCJZzmyT_tc58zIfmCyj4ObH2INZxToJaNd1cZMwKd7RIPVWdnjOvdIKZ5ClriXTMoCaIMfLQ8r-E_Ys3A5RSNDFhDt3VR8Du2sBnpNsx1hYNHrCX6CDDo-UVh6HCJX3XOp3XrN7UKSG-vvIlD8neCxIjkIWmzSrMZ6w';

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
