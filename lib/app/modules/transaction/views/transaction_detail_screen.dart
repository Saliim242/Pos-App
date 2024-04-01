import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/views/success_payment_screen.dart';
import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:pos_manangement_app/app/modules/transaction/views/refund_screen_page.dart';
import 'package:pos_manangement_app/constants/custom_line_clip_path.dart';
import '../../../../constants/constants.dart';
import '../components/resuable_transaction_note_refunde_reason.dart';
import '../components/reusable_transaction_bilingin_money.dart';
import '../components/transaction_info_card_widget.dart';
import '../components/transaction_items_card_widget_paid.dart';
import '../models/new_transac_model.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Theme.of(Get.context!).scaffoldBackgroundColor,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Receipt #${transaction.transactionId}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
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
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<TransactionController>(
        builder: (acc) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  // Transaction Information Details Card
                  TransactionInfoCardWidget(transaction: transaction),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  // Transaction Items Paid  Details Card
                  TransactionItemsPaidCardWidget(transaction: transaction),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  // Transaction Billings  Details Card
                  ClipPath(
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
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "Transactions Billing",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kTexMoneyColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            MySeparator(),
                            SizedBox(height: 20),
                            ReusableTransactionBillingMoney(
                              moneyType: "Subtotal",
                              moneyPrice: transaction.billing?.subtotal ?? 0.0,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kTexMoneyColor,
                            ),
                            SizedBox(height: 20),
                            ReusableTransactionBillingMoney(
                              moneyType: "Discount",
                              moneyPrice: transaction.billing?.discount ?? 0.0,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechSecondColor,
                            ),
                            SizedBox(height: 20),
                            ReusableTransactionBillingMoney(
                              moneyType: "Total",
                              moneyPrice: transaction.totalAmount ?? 0.0,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kTexMoneyColor,
                            ),
                            SizedBox(height: 20),
                            transaction.refundAmount! > 0
                                ? ReusableTransactionBillingMoney(
                                    moneyType: "Refunded Amount",
                                    moneyPrice: transaction.refundAmount ?? 0.0,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechSecondColor,
                                  )
                                : SizedBox(),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  // Transaction Note and Refunded Reason
                  TransactionNotesAndRefundResonCardWidget(
                      transaction: transaction),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  // Products ga Credit In la Baxsho waaye
                  transaction.status == "Credit"
                      ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffEAA029),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "Settle Debt",
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColor.kbgColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 15),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: transaction.status == "Cancelled"
          ? SizedBox()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              height: 100,
              decoration: BoxDecoration(
                color:
                    Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ReusableButtomNavigationBar(
                      bgColor: Color(0xffFEEEEF),
                      color: Color(0xffE88F9B),
                      icon: Iconsax.clipboard_close,
                      title: "Cancle",
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ReusableButtomNavigationBar(
                      bgColor: Color(0xffEAF4FE),
                      color: Color(0xff3196f6),
                      icon: Iconsax.back_square,
                      title: "Refund",
                      onTap: () {
                        Get.to(
                          () => RefundScreenPage(tras: transaction),
                          fullscreenDialog: true,
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ReusableButtomNavigationBar(
                      bgColor: Color(0xffEAF4FE),
                      color: Color(0xff3196f6),
                      icon: Iconsax.share,
                      title: "Share",
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ReusableButtomNavigationBar extends StatelessWidget {
  const ReusableButtomNavigationBar({
    super.key,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final Color color;
  final Color bgColor;
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        // height: 75,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
              8), //AppColor.kJtechSecondColor.withOpacity(0.35),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              "${title}",
              style: TextStyle(
                fontSize: 15,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
