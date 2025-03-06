import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'model/product_list_model.dart';

class ApiService {

  Future<List<ProductListModelItem>?> getProducts({required int offset, required int limit}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.productEndPoint}?offset=$offset&limit=$limit");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        List<ProductListModelItem> data = jsonResponse.map<ProductListModelItem>((json) => ProductListModelItem.fromJson(json)).toList();

        debugPrint("Fetching data: ${data.length}");
        debugPrint("Call response--->\n $jsonResponse");
        return data;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}