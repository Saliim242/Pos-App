import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:http/http.dart' as http;
//import 'package:pos_manangement_app/app/modules/carts/models/cash_model.dart';

class CartProvider extends GetConnect {
  getPaymentMethods() async {
    var response =
        await rootBundle.loadString("lib/app/data/payment_methods_data.json");
    List json = jsonDecode(response);

    //return json.map((e) => CashModelServices.fromJson(e)).toList();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
