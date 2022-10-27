import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';

import '../../constant.dart';

class InconsistencyContainerService {
  Future<int> reportInconsistencyContainer(String containerId, int newQuantity,
      String note, DateTime timestamp) async {
    final res = await http.post(
        Uri.parse(Constants.baseUrl + '/api/lotinconsistencies/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId',
        },
        body: jsonEncode(
          <String, dynamic>{
            "timestamp": DateFormat('yyyy-MM-ddThh:mm:ss')
                .format(DateTime.now())
                .toString(),
            "lotId": containerId,
            "newQuantity": newQuantity,
            // "note": note
            // "timestamp": "2022-08-18T15:00:01",
            // "containerId": "r4",
            // "newQuantity": 200,
            "note": note
          },
        ));
    print(res.statusCode.toString());
    return res.statusCode;
  }
}
