import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../models/customer_model.dart';

class CustomersCardWidget extends StatelessWidget {
  const CustomersCardWidget({
    super.key,
    required this.model,
    this.onTap,
  });

  final CustomerModel model;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Theme.of(context).cardColor
              : Colors.white, // Set Container background color to white
          boxShadow: [
            Get.isDarkMode
                ? BoxShadow()
                : BoxShadow(
                    color: Colors.grey.shade300
                        .withOpacity(0.8), // Set shadow color
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.customerName}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "(252) ${model.customerPhone}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor.withOpacity(0.65)
                          : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                    ),
                  ),
                ],
              ),
            ),
            model.credit > 0
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColor.kSecondDarkColor
                          : Color(0XFFe0faef), //Color(0xff8ba3d1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "${moneyFormater(model.credit).compactSymbolOnLeft}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : Color(0xff16c57D),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
