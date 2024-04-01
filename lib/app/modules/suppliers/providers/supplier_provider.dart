import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/suppliers/models/suppiler_model.dart';

class SupplierProvider extends GetConnect {
  getSuppliers() async {
    var response = await rootBundle.loadString('lib/app/data/supplier.json');

    List data = jsonDecode(response);

    return data.map((e) => SupplierModel.fromJson(e)).toList();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
