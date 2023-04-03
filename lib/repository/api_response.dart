import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import 'constants.dart';

class APIConnect {
  List<ProductModel> postList = [];
  Future<List<ProductModel>> getPostApi() async {
    final resposne = await http
        .get(Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint));
    var data = jsonDecode(resposne.body);
    if (resposne.statusCode == 200) {
      postList.clear();
      for (var element in data) {
        var post = ProductModel.fromJson(element);
        postList.add(post);
      }
      print(data);
      return postList;
    } else {
      return postList;
    }
  }
}
