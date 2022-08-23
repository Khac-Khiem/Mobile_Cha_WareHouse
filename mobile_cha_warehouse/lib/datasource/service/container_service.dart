import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_cha_warehouse/constant.dart';
import 'package:mobile_cha_warehouse/datasource/models/container_model.dart';


class ContainerService {
  Future getContainerLocation(String id) async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl+
           'api/containers/$id'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
      ContainerModel items = ContainerModel.fromJson(body);
      return items;
    } else {
      
      throw "Unable to retrieve posts.";
    }
  }
}
