import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/transaction/models/transaction_model.dart';

import '../models/new_transac_model.dart';

class TransactionProvider extends GetConnect {
  // getTransactions() async {
  //   var response = await rootBundle.loadString("lib/app/data/transaction.json");
  //   List json = jsonDecode(response);

  //   log(json.toString(), name: "All Transactions Are Readed");

  //   return json.map((e) => TransactionModel.fromJson(e)).toList();
  // }

  getTransactions() async {
    var response =
        await rootBundle.loadString("lib/app/data/new_transaction.json");
    List json = jsonDecode(response);

    log(json.toString(), name: "All Transactions Are Readed");

    return json.map((e) => TransactionModel.fromJson(e)).toList();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
