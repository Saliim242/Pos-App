import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/constants.dart';
import '../models/customer_model.dart';

class CustomersCard extends StatelessWidget {
  const CustomersCard({
    super.key,
    required this.customer,
  });

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          Get.isDarkMode
              ? BoxShadow()
              : BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(1, 1),
                  blurRadius: 1,
                )
        ],
      ),
      child: ListTile(
        tileColor: Colors.transparent,
        title: Text(
          "${customer.customerName}",
          style: TextStyle(
            fontSize: 17,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        subtitle: Text(
          "${customer.customerPhone}",
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor.withOpacity(0.7)
                : AppColor.kJtechPrimaryColor.withOpacity(0.7),
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? AppColor.kSecondDarkColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Icon(
            IconlyBroken.profile,
            color:
                Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechSecondColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
