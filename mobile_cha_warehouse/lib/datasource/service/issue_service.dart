import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/models/lots_data_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/domain/entities/error_package.dart';
import 'package:mobile_cha_warehouse/domain/entities/lots_data.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

import '../../constant.dart';
import '../models/error_package_model.dart';

class IssueService {
  List bodyJson = [];
  Future<List<GoodsIssueModel>> getGoodsIssue() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + 'api/goodsissues/pending'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'Authorization': 'Bearer $tokenId',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsIssueModel> allIssues = body
          .map(
            (dynamic item) => GoodsIssueModel.fromJson(item),
          )
          .toList();
      return allIssues;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<GoodsIssueModel> getGoodsIssueById(String id) async {
    final res = await http
        .get(Uri.parse(Constants.baseUrl + 'api/goodsissues/$id'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
    });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      GoodsIssueModel issue = GoodsIssueModel.fromJson(body);

      return issue;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackage> addContainerIssue(
      String issueId, List<Lots> lots) async {
    bodyJson.clear();
    for (int i = 0; i < lots.length; i++) {
      Map<String, dynamic> containerJson = {
        "lotId": lots[i].lotId,
        "quantity": lots[i].quantity
        //  "containerId": "r1",
        // "quantity": 50
      };
      bodyJson.add(containerJson);
    }
    final response = await http.patch(
        Uri.parse(Constants.baseUrl + 'api/goodsissues/$issueId/lots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $tokenId',
        },
        body: jsonEncode(bodyJson));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return ErrorPackage("success", "success");
    } else {
      dynamic body = jsonDecode(response.body);
      ErrorPackage error = ErrorPackageModel.fromJson(body);
      return error;
    }

    // if (response.statusCode == 200) {
    //   print('success');
    // } else {
    //   print('fail');
    // }
  }

  Future getLotByItemId(String itemId) async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + '/api/lots/?itemId=$itemId'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer $token',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<LotsModel> lots = body
          .map(
            (dynamic item) => LotsModel.fromJson(item),
          )
          .toList();
      return lots;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
