import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';
import '../../carts/views/success_payment_screen.dart';
import '../models/new_transac_model.dart';

import 'reusable_transaction_info_widget.dart';

class TransactionNotesAndRefundResonCardWidget extends StatelessWidget {
  const TransactionNotesAndRefundResonCardWidget({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CouponClipper(
        direction: Directionality.of(context),
        curvePosition: MediaQuery.of(context).size.height * 0.07,
        curveRadius: 40,
        curveAxis: Axis.horizontal,
      ),
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.receipt_1,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kTexMoneyColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Transaction Notes and Refund Reason",
                    style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kTexMoneyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              MySeparator(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              TransactionWidgetInfo(
                customerOrCashierNames: "${transaction.notes ?? ""}",
                title: "Transaction Notes",
              ),
              SizedBox(height: 20),
              transaction.refundAmount! > 0
                  ? TransactionWidgetInfo(
                      customerOrCashierNames:
                          "${transaction.refundReason ?? ""}",
                      //"${transaction.cashierName}",
                      title: "Refunded Reason",
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              // Date Time

              // TransactionWidgetInfo(
              //   customerOrCashierNames: "${transaction.paymentMethod}",
              //   title: "Payment Method Type",
              // ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
