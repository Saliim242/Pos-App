import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class TransactionWidgetInfo extends StatelessWidget {
  const TransactionWidgetInfo({
    super.key,
    required this.customerOrCashierNames,
    required this.title,
  });

  final String customerOrCashierNames;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title}",
          style: TextStyle(
            fontSize: 14,
            color: Get.isDarkMode
                ? AppColor.kbgColor.withOpacity(0.75)
                : AppColor.kJtechPrimaryColor.withOpacity(0.75),
          ),
        ),
        Text(
          "${customerOrCashierNames}",
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ],
    );
  }
}
