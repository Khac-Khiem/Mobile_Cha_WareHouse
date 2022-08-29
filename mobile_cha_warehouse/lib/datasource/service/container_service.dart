import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';

class ContainerService {
  Future getContainerById(String id) async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + 'api/containers/$id'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
      ContainerModel items = ContainerModel.fromJson(body);
      return items;
    } else {
      print('rổ không xác định');

      return throw "Unable to retrieve posts.";
    }
  }

  Future getExportContainer() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + '/api/containers/importing'),
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      //   print(body.toString());
      List<ContainerModel> items =
          body.map((e) => ContainerModel.fromJson(e)).toList();
      return items;
    } else {
      return throw "Unable to retrieve posts.";
    }
  }
}
