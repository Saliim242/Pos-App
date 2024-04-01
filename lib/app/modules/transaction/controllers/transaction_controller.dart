import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:pos_manangement_app/app/modules/transaction/providers/transaction_provider.dart';
import '../../../../constants/constants.dart';
import '../models/new_transac_model.dart';

class TransactionController extends GetxController {
  final TextEditingController transactionController = TextEditingController();
  double totalRefund = 0.0;
  List<TransactionModel> transactions = [];
  List<TransactionModel> filteredTransactions = [];
  bool isLoading = false;

  // void addTransaction(TransactionModel transaction) {
  //   transactions.add(transaction);
  //   update();
  // }

  // Load All Our Customers Function
  loadTransactions() async {
    try {
      isLoading = true;
      update();
      // if (customers.isEmpty) {
      //   isLoading = true;
      //   update();
      // }

      await Future.delayed(Duration(seconds: 2));

      transactions = await TransactionProvider().getTransactions();

      log("Transactions ${transactions.length}");

      update();
    } catch (e) {
      transactions = [];

      update();

      Logger().e("Load Transaction error", error: e.toString());
    } finally {
      //log("Transactions are ${transactions .customerName}");
      isLoading = false;
      update();
    }
  }

  // Filter Transactions

  void searchTransactions(String value) {
    // Update the filteredCustomers list based on the search query
    filteredTransactions = transactions
        .where(
          (element) => (element.transactionId!.toString().contains(
                value,
              )),
        )
        .toList();

    update();
  }

  @override
  void onInit() async {
    await loadTransactions();
    filteredTransactions = transactions;

    super.onInit();
  }

  /// Date Time Formating
  ///
  final formatTime = DateFormat('HH:mm a').format(DateTime.now());

  // String checkInAttended = DateFormat("HH:mm").format(DateTime.parse
  //   (attendance!.checkIn!));

  final time = DateFormat(' a').format(DateTime.now());
  final formatDate = DateFormat('EEEE, d MMMM , yyyy').format(DateTime.now());
  final formatDay = DateFormat('EEEE').format(DateTime.now());

  final List filterTransactionData = [
    "All",
    "Paid + Credit",
    "Credit",
    "Paid",
    "Cancelled",
    "Fully Refunded",
    "Partially Refunded",
  ];
  //"Partially Refunded",

  // Update Selection Of Filtering Data
  String filterTransactionType = 'All';
  void updateFilterTransactionType(String type) {
    filterTransactionType = type;
    //update();
  }

  void applayFilteredTransactionData() {
    log("Staus Type Filtered is : ${filterTransactionType}");

    filterTransactionType;
    update();
  }

  /// Filtered Transaction

  void filteredTransaction(String value) {
    // Update the filteredCustomers list based on the search query

    if (filterTransactionType == "All") {
      filteredTransactions = transactions;
      update();
    } else if (filterTransactionType == "Paid + Credit") {
      filteredTransactions = transactions
          .where(
            (element) => element.status == "Paid" || element.status == "Credit",
          )
          .toList();
      update();
    } else {
      filterTransactionType;
      update();
      filteredTransactions = transactions
          .where(
            (element) => (element.status!.toLowerCase().contains(
                  filterTransactionType.toLowerCase(),
                )),
          )
          .toList();
    }

    update();
  }

  Color getBackgroundColor(String currentType) {
    // if (currentType == selectedType) {
    //   return Colors.blueAccent.withOpacity(0.1); // Selected color
    // } else {
    switch (currentType) {
      // case "Paid + Credit":
      //   return Colors.yellow.withOpacity(0.1); // Change to your desired color
      case "Credit":
        return Color(0xffD0F2FE); // Change to your desired color
      case "Paid":
        return Color(0XFF00d27b); // Change to your desired color
      case "Cancelled":
        return Color(0XFFc3c3c3); // Change to your desired color
      case "Fully Refunded":
        return Color(0XFFF25369); // Change to your desired color
      case "Partially Refunded":
        return Color(0XFFF68E57); // Change to your desired color
      default:
        return Color(0XFF00d27b);
    }
  }

  /// Select Refund Product Item

  bool isSelected = false;

  updateNewValue(bool value, int index) {
    selectedProducts[index] = value;
    // Update "Select All" checkbox based on individual selections
    selectAll = selectedProducts.every((element) => element);

    update();
  }

  /// This Section is Selection Of Which Product YOU NEED TO REDUND

  bool selectAll = false;
  List<bool> selectedProducts = [];

  void selectAllF(bool? value, TransactionModel transactions) {
    selectAll = value!;
    // Update the selectedProducts list based on "Select All"
    selectedProducts = List.generate(
      transactions.products!.length,
      (index) => selectAll,
    );
    update();
  }

  //  Calculate To Refunded Products
  String calculateSelectedTotal(TransactionModel transaction) {
    double total = 0;
    for (int i = 0; i < selectedProducts.length; i++) {
      if (selectedProducts[i]) {
        // total += transaction.products![i].quantity! *
        //     transaction.products![i].price!;

        total += (transaction.products![i].quantity! *
            (transaction.products![i].price! - transaction.billing!.discount!));
      }
    }
    return moneyFormater(total).compactSymbolOnLeft;
  }
}
