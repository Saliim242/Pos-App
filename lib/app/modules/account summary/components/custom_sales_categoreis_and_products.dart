import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class AccountTopSellingByCategoriesAndProducts extends StatelessWidget {
  const AccountTopSellingByCategoriesAndProducts({
    super.key,
    required this.categoriesName,
    required this.sellingPrice,
    required this.howManyItems,
  });

  final String categoriesName;
  final int sellingPrice;
  final int howManyItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(
        "${categoriesName}",
        style: TextStyle(
          fontSize: 15,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
      ),
      subtitle: Text(
        "${howManyItems} items",
        style: TextStyle(
          fontSize: 13,
          color: Get.isDarkMode ? AppColor.kbgColor : AppColor.kTexMoneyColor,
        ),
      ),
      trailing: Text(
        "${moneyFormater(sellingPrice.toDouble()).compactSymbolOnLeft}",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff16c57D),
          fontWeight: FontWeight.w600,
          // Get.isDarkMode
          //     ? AppColor.kbgColor
          //     : AppColor.kJtechPrimaryColor,
        ),
      ),
    );
  }
}
