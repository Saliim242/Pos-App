import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';

class CustomerProvider extends GetConnect {
  getCustomers() async {
    var response = await rootBundle.loadString("lib/app/data/customers.json");
    List json = jsonDecode(response);

    return json.map((e) => CustomerModel.fromJson(e)).toList();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
