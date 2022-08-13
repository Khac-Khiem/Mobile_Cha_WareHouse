import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/datasource/models/goods_issues_model.dart';

class IssueService {
  Future<List<GoodsIssueModel>> getGoodsIssue(String startDate) async {
    final res = await http.get(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/?Page=1&ItemsPerPage=1000&StartTime=$startDate&EndTime=2023-05-30'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      List<dynamic> bodyResponse = body['items'];
      //  print(bodyResponse.toString());
      List<GoodsIssueModel> allIssues = bodyResponse
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
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$id'),
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

  Future<void> confirmIssue(String issueId, List<String> containerId) async {
    final response = await http.patch(
        Uri.parse(
            'https://cha-warehouse-management.azurewebsites.net/api/goodsissues/$issueId/containers/confirmed'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode(containerId));

    if (response.statusCode == 200) {
      print('success');
    } else {
      print('fail');
    }
  }
}
