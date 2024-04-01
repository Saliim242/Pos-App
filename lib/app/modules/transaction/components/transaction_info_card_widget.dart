import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';
import '../../carts/views/success_payment_screen.dart';
import '../controllers/transaction_controller.dart';
import '../models/new_transac_model.dart';
import 'reusable_transaction_info_widget.dart';

class TransactionInfoCardWidget extends StatelessWidget {
  const TransactionInfoCardWidget({
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
                    "Transaction Infomation",
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
                customerOrCashierNames:
                    "${transaction.customer?.customerName ?? ""}",
                title: "Customer Name",
              ),
              SizedBox(height: 20),
              TransactionWidgetInfo(
                customerOrCashierNames: "${transaction.cashierName ?? ""}",
                //"${transaction.cashierName}",
                title: "Cashier Name",
              ),
              SizedBox(height: 20),
              // Date Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontSize: 13,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor.withOpacity(0.65)
                          : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                    ),
                  ),
                  GetBuilder<TransactionController>(builder: (acc) {
                    return Row(
                      children: [
                        Text(
                          "${transaction.transactionDate}", //acc.formatDate
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${transaction.transactionTime}", //acc.formatTime
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),

              SizedBox(height: 20),
              TransactionWidgetInfo(
                customerOrCashierNames: "${transaction.paymentMethod}",
                title: "Payment Method Type",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
