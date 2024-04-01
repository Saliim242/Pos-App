import 'dart:convert';
import 'dart:developer';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends GetConnect {
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

  //'https://dummyjson.com/products?_limit=$limit&_page=$page'

  // getProductsLimit({int limit = 10, int skip = 0}) async {
  //   var response = await http.get(
  //       Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'));

  //   if (response.statusCode == 200) {
  //     final decodeData = jsonDecode(response.body);

  //     log(decodeData.toString(), name: "All Products Are Readed");

  //     return decodeData['products'];
  //     //decodeData.map((e) => ProductModel.fromJson(e)).toList();
  //     //ProductModel.fromJson(decodeData);
  //   }
  // }

  //'https://dummyjson.com/products'

  getProducts() async {
    var isAPICacheKeyExist =
        await APICacheManager().isAPICacheKeyExist('API_PRODUCTS');
    if (!isAPICacheKeyExist) {
      var response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel =
            await APICacheDBModel(key: "API_PRODUCTS", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        final decodeData = jsonDecode(response.body);

        //  log(decodeData.toString(), name: "All Products Are Readed");

        return decodeData['products'];
        //decodeData.map((e) => ProductModel.fromJson(e)).toList();
        //ProductModel.fromJson(decodeData);
      }
    } else {
      var cacheData = await APICacheManager().getCacheData("API_PRODUCTS");
      final decodeData = jsonDecode(cacheData.syncData);

      return decodeData['products'];
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
