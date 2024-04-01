import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class CategoryTypeAndStockLength extends StatelessWidget {
  final IconData iconData;
  final String title;
  const CategoryTypeAndStockLength({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 15,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
