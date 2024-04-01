import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';
import '../../carts/views/success_payment_screen.dart';
import '../models/new_transac_model.dart';
import 'reusable_transaction_items_paid_widget.dart';

class TransactionItemsPaidCardWidget extends StatelessWidget {
  const TransactionItemsPaidCardWidget({
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
            children: [
              Row(
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
                        "Taransaction Items",
                        style: TextStyle(
                          fontSize: 15,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kTexMoneyColor,
                        ),
                      )
                    ],
                  ),
                  transaction.refundAmount! > 0
                      ? Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: transaction.status == "Partially Refunded"
                                ? Color(0XFFFEF5E4)
                                : Color(0XFFFBEBEC),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${transaction.status}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : transaction.status == "Partially Refunded"
                                      ? Color(0xffEAA029)
                                      : Color(0xffcb374b),
                            ),
                          ),
                        )
                      : Text(""),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              MySeparator(),
              SizedBox(height: 20),

              // Lsit Ve
              ListView.builder(
                itemCount: transaction.products!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ReusableTransactionItemsWidget(
                      howManyItems:
                          "${transaction.products![index].quantity} x ${transaction.products![index].price} ",
                      productType:
                          "${transaction.products![index].productName}",
                      price: double.parse(transaction
                          .products![index].totalPerProduct
                          .toString()),
                    ),
                  );
                },
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
