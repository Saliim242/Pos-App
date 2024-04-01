import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:money_formatter/money_formatter.dart';

class AppColor {
  AppColor._();
  static Color kbgColor = const Color(0xffe5e5e5);

  static Color kSecondDarkColor = const Color(0xff474555);
  static Color kThirdDarkColor = const Color(0xff25243F);

  static Color kJtechPrimaryColor = const Color(0xff3E3C59);

  static Color kJtechSecondColor = const Color(0xffEE4062);

  static Color kJtechShadowColor = const Color(0xffFAF8FF);

  static Color kTexMoneyColor = Color(0xff1746A2); // 1746A2    ---1f4690
}

MoneyFormatterOutput moneyFormater(double money) {
  MoneyFormatterOutput fo =
      MoneyFormatter(amount: double.parse(money.toString())).output;

  return fo;
}

AppBar app = AppBar(
  automaticallyImplyLeading: false,
  elevation: Get.isDarkMode ? 0.5 : 0.5,
  backgroundColor: //Theme.of(Get.context!).primaryColor,
      Get.isDarkMode
          ? Theme.of(Get.context!).cardColor
          : Theme.of(Get.context!).scaffoldBackgroundColor,
  centerTitle: true,
  title: Marquee(
    child: Text(
      'Add New Product',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
      ),
    ),
  ),
  leading: GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Icon(
      Iconsax.back_square,
      //IconlyBroken.more_square,
      //color: Get.theme.hoverColor,
      color: Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
    ),
  ),
);
