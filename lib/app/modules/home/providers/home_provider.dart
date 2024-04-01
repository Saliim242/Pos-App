import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends GetConnect {
  // Get All Products From API

  // getProducts() async {
  //   var response =
  //       await http.get(Uri.parse('https://fakestoreapi.com/products'));

  //   if (response.statusCode == 200) {
  //     List decodeData = jsonDecode(response.body);

  //     //log(decodeData.toString(), name: "All Products Are Readed");

  //     return decodeData.map((e) => ProductModel.fromJson(e)).toList();
  //     //ProductModel.fromJson(decodeData);
  //   }
  // }

  getProducts() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);

      log(decodeData.toString(), name: "All Products Are Readed");

      return decodeData['products'];
      //decodeData.map((e) => ProductModel.fromJson(e)).toList();
      //ProductModel.fromJson(decodeData);
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
