// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';

import '../../../../constants/constants.dart';

class AddDiscountTextFeild extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final IconData? passIcon;

  final TextEditingController controller;

  final TextAlign textAlign;
  final Color? color;

  AddDiscountTextFeild({
    Key? key,
    required this.hintText,
    this.iconData,
    this.passIcon,
    required this.controller,
    this.textAlign = TextAlign.start,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersController>(builder: (e) {
      return TextFormField(
        textAlign: textAlign,

        //autofocus: true,
        scrollPadding: EdgeInsets.all(0),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Get.isDarkMode
                ? Colors.grey.shade300.withOpacity(0.6)
                : AppColor.kJtechPrimaryColor.withOpacity(0.6),
          ),
          prefixIcon: Icon(
            iconData,
            size: 25,
            color: Get.isDarkMode
                ? AppColor.kbgColor.withOpacity(0.6)
                : AppColor.kTexMoneyColor,
          ),
        ),
        style: TextStyle(
          fontSize: 25,
          //fontWeight: FontWeight.w600,
          color: color,
        ),
      );
    });
  }
}
