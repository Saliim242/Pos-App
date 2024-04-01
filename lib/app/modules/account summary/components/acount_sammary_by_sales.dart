import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constants/constants.dart';

// This Suction is the suction of How many Total Income  we MADE  today and how manay cost of goods  we made
// and How manay  cost price we made and e.t.c
class AccountSammaryMoney extends StatelessWidget {
  const AccountSammaryMoney({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  final String title;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${title}",
            style: TextStyle(
              fontSize: 15,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${moneyFormater(amount).compactSymbolOnLeft}",
            style: TextStyle(
              fontSize: 18,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}

// This Suction is the Main  suction  That Holds All Our UI And Displays It
class AcountSummaryBySales extends StatelessWidget {
  const AcountSummaryBySales({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountSammaryMoney(
          title: "Total Income",
          amount: 6500,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        AccountSammaryMoney(
          title: "Cost of Goods (Cost Price)",
          amount: 300,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        AccountSammaryMoney(
          title: "Cost of Profit (Profit Margin)",
          amount: 450,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          children: [
            Expanded(
              child: AccountSammaryMoney(
                title: "Net Profit",
                amount: 450,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AccountSammaryMoney(
                title: "Discount",
                amount: 200,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechSecondColor,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AccountSummeryItemSoldAndTrasReusable(
                icon: Iconsax.people,
                title: "Customers",
                total: "15",
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AccountSummeryItemSoldAndTrasReusable(
                icon: Iconsax.percentage_square,
                title: "Transactions",
                total: "3",
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

        // Refund And Item Sold
        Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AccountSummeryItemSoldAndTrasReusable(
                icon: Iconsax.receipt_item,
                title: "Item Solds",
                total: "12",
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AccountSummeryItemSoldAndTrasReusable(
                icon: Iconsax.back_square,
                title: "Refund",
                total: "35.00",
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechSecondColor,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}

// This Suction is the suction of How many Customer we add today and how manay tarasaction we made
// and How manay Refund acour

class AccountSummeryItemSoldAndTrasReusable extends StatelessWidget {
  const AccountSummeryItemSoldAndTrasReusable({
    super.key,
    required this.title,
    required this.icon,
    required this.total,
    required this.color,
  });

  final String title;
  final IconData icon;
  final String total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffEAF4FD),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: AppColor.kTexMoneyColor,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "${title}",
                style: TextStyle(
                  fontSize: 15,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${total}',
                  style: TextStyle(
                    fontSize: 17,
                    color: color,
                    //  Get.isDarkMode
                    //     ? AppColor.kbgColor
                    //     : AppColor.kJtechPrimaryColor,
                  ),
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(2, 0),
                    child: Text(
                      '/Today',
                      //superscript is usually smaller in size
                      textScaleFactor: 0.7,

                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor.withOpacity(0.65)
                            : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
