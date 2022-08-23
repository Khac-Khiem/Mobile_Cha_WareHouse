import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';
import 'package:mobile_cha_warehouse/datasource/service/receipt_service.dart';
import 'package:mobile_cha_warehouse/presentation/screens/issue/issue_params.dart';

import '../../constant.dart';

class IssueService {
  List bodyJson = [];
  Future<List<GoodsIssueModel>> getGoodsIssue() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl+
          'api/goodsissues/pending/all'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
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
    final res = await http.get(
        Uri.parse(Constants.baseUrl+
            'api/goodsissues/$id'),
        headers: {
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

  Future<int> addContainerIssue(
      String issueId, List<ContainerIssueExportServer> containers) async {
    for (int i = 0; i < containers.length; i++) {
      Map<String, dynamic> containerJson = {
        // "containerId": containers[i].containerId,
        // "quantity": containers[i].quanlity
         "containerId": "r1",
        "quantity": 50
      };
      bodyJson.add(containerJson);
    }
    final response = await http.patch(
        Uri.parse(Constants.baseUrl+
            'api/goodsissues/g1/containers'),
        headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body:
            jsonEncode(bodyJson));
           
    print(response.statusCode);
    return response.statusCode;

    // if (response.statusCode == 200) {
    //   print('success');
    // } else {
    //   print('fail');
    // }
  }

  Future<int> confirmIssue(String issueId) async {
    final response = await http.patch(
      Uri.parse(Constants.baseUrl +
          'api/goodsissues/$issueId/containers/confirmed'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
   if (response.statusCode == 200) {
      print('confirm success');
      return response.statusCode;
    } else {
      print('confirm fail');
      return response.statusCode;
    }
  }
}
