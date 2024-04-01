import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/constants.dart';

class DateRangePicker extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String dateRange;

  const DateRangePicker({
    super.key,
    required this.title,
    this.onTap,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        InkWell(
          onTap: onTap,
          child: Container(
            //padding: EdgeInsets.all(15),
            height: 55,
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? AppColor.kSecondDarkColor
                  : AppColor.kTexMoneyColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  dateRange.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  ),
                ),
                Icon(
                  IconlyLight.calendar,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
