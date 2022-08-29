import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/constant.dart';
import '../../presentation/screens/receipt/receipt_params.dart';

String token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IkU0OUZBQkNEMjRGNkE5M0IxODdERUVBMDRGNDQ5RTI3IiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjA4MjIxMDE0MTkuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NjE2OTc5MjUsImlhdCI6MTY2MTY5NzkyNSwiZXhwIjoxNjYxNzI2NzI1LCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjA4MjIxMDE0MTkuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNTIwY2FjM2QtZDUzMS00ZDQxLTY4MTgtMDhkYTgzZWUyMWYyIiwiYXV0aF90aW1lIjoxNjYxNjk3ODY2LCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiWEFHWERYSzRPVlIzQVZHSzVTQ1ZFSlgzTEVaMkVaUE8iLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJwa2toaWVtIiwibmFtZSI6InBra2hpZW0iLCJzaWQiOiI3QTJDQTQ5QUJGQUFENTFDNEU3QTUyRkQwM0MyMDA5OSIsImp0aSI6IkIzRUY4M0FBRjUxMkU3RDVDNEREMEM5M0ZEQURGMUVBIn0.s37sikpEVWVeN66gMPHpmxLaewtwq4xi1jc6B6Y_UH24HklP-8WYEnwPKi7VDYniO0_VBbwZwGJ-GChcwzf7IIejSSttJJSrdkg33EkwHkQReUJ7k9MN8tc6015Boyu4gfFf_A9p2sFlPXv-driRj396nxXf-PHj7O7VHUN_xZ6OMJO30JeqzurQgd3Emgtg_azbMqWVsR66_mXurjQafiScVx05MXiMbnC9HdVjBDA3mme4UtSuhHPm__QeQOSThmr3eaxVZdcdxOXC2NYBXUPqwIlzh_bZwBkMBHZ55CYGSAcSMxbsJcz5W7qpJwq18mMCMw_N5DNer2XMJHHeWg';

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
