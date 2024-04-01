import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_manangement_app/app/modules/account%20summary/components/exports.dart';

import '../../../../constants/constants.dart';
import '../components/account_sammary_by_sales_product.dart';

class AccountSummaryController extends GetxController {
  int currentSummary = 0;

  void updateSummary(int index) {
    currentSummary = index;
    print("${summary[currentSummary]}");
    update();
  }

  List summary = [
    "Sales",
    "Invontry",
    "Sales By Products",
    "Payment Methods",
  ];

  List filteredDays = [
    "Today",
    "Last 7 Days",
    "This Month",
    "Past 3 Months",
    "This Year",
  ];

  // Update Selection Of Filtering Data
  String filterType = 'Today';
  void updateFilterType(String type) {
    filterType = type;
    // update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  List text = [
    AcountSummaryBySales(),
    AcountSummaryByInventory(),
    AcountSummaryBySalesProduct(),
    AcountSummaryByPaymentMethodsType(),
  ];

  /////   Choose Period Time
  DateTime? starDate;
  DateTime? endDate;
  late DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  // Select Range Date Function
  chooseDateRange(BuildContext context) async {
    DateTimeRange? rangeDate = await showDateRangePicker(
      //initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: "Select Your Date To Leave",
      currentDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            hintColor: Colors.green, // Change accent color
            colorScheme: ColorScheme.light(
              primary: Get.isDarkMode
                  ? AppColor.kJtechPrimaryColor
                  : AppColor.kJtechSecondColor,
            ),
          ),
          child: child!,
        );
      },

      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
    );
    if (rangeDate != null) {
      dateRange = rangeDate;
      //dateRange.start = rangeDate.start;
      starDate = rangeDate.start;
      endDate = rangeDate.end;

      update();
    }
  }

  /// Upplay Filtered Data
  ///
  bool dismi = false;
  void applayFilteredData() {
    log("Start Date : ${DateFormat('dd-MMM-yyyy').format(dateRange.start)} and End Date is : ${DateFormat('dd-MMM-yyyy').format(dateRange.end)}");
    log("Staus Type Filtered is : ${filterType}");

    filterType;
    update();

    dismi = true;
    update();
  }
}

/*


    Formula Total Sales Income

    Total Sales Income = Quantity Sold * Selling Price Per item 


    Formala Total Cost of Goods

    Total Cost of Goods = Quantity of items sold * Cost per Item

    Formula Gross Profit 

    Gross Margin(Gross Profit) = Revenue - Cost of Goods Sold (COSGS)






*/
