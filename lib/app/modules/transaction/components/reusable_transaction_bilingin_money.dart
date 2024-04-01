import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class ReusableTransactionBillingMoney extends StatelessWidget {
  const ReusableTransactionBillingMoney({
    super.key,
    required this.moneyType,
    required this.moneyPrice,
    required this.color,
  });

  final String moneyType;
  final double moneyPrice;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${moneyType}",
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        Text(
          "${moneyFormater(moneyPrice).compactSymbolOnLeft}",
          style: TextStyle(
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}
