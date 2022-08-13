import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../presentation/screens/receipt/receipt_params.dart';

String token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjU2QzJFNzI3OUExN0UwMDc3RTVFOTJFMDAzRDg4NUFCIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQiLCJuYmYiOjE2NTMyOTMzNTMsImlhdCI6MTY1MzI5MzM1MywiZXhwIjoxNjUzMzIyMTUzLCJhdWQiOiJodHRwczovL2F1dGhlbnRpY2F0aW9uc2VydmVyMjAyMjAxMTEwOTQzNDMuYXp1cmV3ZWJzaXRlcy5uZXQvcmVzb3VyY2VzIiwic2NvcGUiOlsib3BlbmlkIiwibmF0aXZlLWNsaWVudC1zY29wZSIsInByb2ZpbGUiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJuYXRpdmUtY2xpZW50Iiwic3ViIjoiNDMyYmIxMmItOTcxZi00ZDZmLTc3ZTMtMDhkYTJmNDA2Yjc0IiwiYXV0aF90aW1lIjoxNjUzMjkzMzUyLCJpZHAiOiJsb2NhbCIsIkFzcE5ldC5JZGVudGl0eS5TZWN1cml0eVN0YW1wIjoiN0dKSFNHNFlLWVlWNk1JT0hFNU82S1hFS1JNSUpPV0ciLCJyb2xlIjoiV2FyZWhvdXNlQ29vcmRpbmF0b3IiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuaG1kdW5nIiwibmFtZSI6Im5obWR1bmciLCJzaWQiOiJGQkI1RDY0MTAyNTREMjUzMUI2MzUzMDAwRDJDRkE3NCIsImp0aSI6IkJCNkMzREJFOTkwQkRDNzE5QUM2Mzk3RDA5MDdBQUMzIn0.hM5_cU3THhGwaQeW7Pib3RTOpodRVLurOW_NIfmtF7NP8I1zVn-FRinZggmnFHca-VoEuEcu66DB7uIlKQmPaeJESBop0g1zWQivJpVLmvWKYEk0M6mVhezAR8OdAyy-S1-X-QWZMqsjVRjDu8WuB44MNtfQ2kckft7urxqwI7Aoy2lKcfJYUoKty49F7yZtCMPbqQCGbOmkLyJhw_duDN7nl7kENBLKIOuEA5ScQWyfaUuvuEVPMIBpDTXGryNLFDnYZUYQZlaDgsbwjs-HBTmJDy_mvoNxYqABnPqU9JJ5TdV9CysyBNT2xL7jxUyLTmbSBluHlcfrqTQ1XDeFfg';

class ReceiptService {
  List bodyJson = [];
  Future postNewReceiptService(
      List<GoodsReceiptEntryContainerData> goodsReceiptEntryContainerData,
      String receiptId) async {
    for (int i = 0; i < goodsReceiptEntryContainerData.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "itemId": goodsReceiptEntryContainerData[i].itemId,
        "employeeId": goodsReceiptEntryContainerData[i].employeeId,
        "containerId": goodsReceiptEntryContainerData[i].containerId,
        "quantity": goodsReceiptEntryContainerData[i].actualQuantity,
        "productionDate": goodsReceiptEntryContainerData[i].productionDate
      };
      bodyJson.add(dimensionJson);
    }
    final res = await http.post(
        Uri.parse('https://cha-warehouse-management.azurewebsites.net/api/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        // body: json.encode(goodsReceiptEntryContainerData)
        body: jsonEncode(<Map<String, dynamic>>[
          {
            "goodsReceiptId": receiptId,
            "timestamp": DateTime.now(),
            "containers": bodyJson
          },
        ]));

    return res.statusCode;
  }

  Future updateLocationService(
      String containerId, String shelfId, int rowId, int id) async {
    final res = await http.patch(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/containers/$containerId/location'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<Map<String, dynamic>>[
          {
            "shelfId": shelfId,
            "row": rowId,
            "column": id
          },
        ]));

    return res.statusCode;
  }
}
