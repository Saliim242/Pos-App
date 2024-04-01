import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class ReusableTransactionItemsWidget extends StatelessWidget {
  const ReusableTransactionItemsWidget({
    super.key,
    required this.productType,
    required this.howManyItems,
    required this.price,
  });

  final String productType;
  final String howManyItems;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${productType}",
              style: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            Text(
              "${howManyItems}",
              style: TextStyle(
                fontSize: 13,
                color: Get.isDarkMode
                    ? AppColor.kbgColor.withOpacity(0.65)
                    : AppColor.kJtechPrimaryColor.withOpacity(0.65),
              ),
            ),
          ],
        ),
        Text(
          "${moneyFormater(price).compactSymbolOnLeft}",
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode ? AppColor.kbgColor : AppColor.kTexMoneyColor,
          ),
        )
      ],
    );
  }
}
