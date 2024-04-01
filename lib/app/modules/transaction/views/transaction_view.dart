import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/components/custom_error_screens.dart';
import 'package:pos_manangement_app/app/modules/components/custom_list_view_animation.dart';
import '../../../../constants/constants.dart';
import '../../carts/views/payment_method_as_credit_page.dart';
import '../components/filter_transaction_data.dart';
import '../controllers/transaction_controller.dart';
import '../models/new_transac_model.dart';
import 'transaction_detail_screen.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
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
            'All Transactions',
            style: TextStyle(
              fontSize: 15,
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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            // decoration: BoxDecoration(
            //   color: Color(0XFFE5F1FF),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  // isDismissible: acs.dismi,
                  backgroundColor:
                      Get.isDarkMode ? const Color(0xff181D2D) : Colors.white,
                  elevation: 0,
                  // showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return FilteredTransactionDataCard();
                  },
                );
              },
              icon: Icon(
                Iconsax.filter_add,
                color: Get.isDarkMode
                    ? AppColor.kbgColor.withOpacity(0.65)
                    : AppColor.kTexMoneyColor,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     IconlyBroken.filter,
          //   ),
          // )
        ],
      ),
      body: GetBuilder<TransactionController>(
        builder: (tras) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  SearchbleTextFeilds(
                    controller: tras.transactionController,
                    text: "Search Transactions You Need!",
                    icon: Iconsax.search_favorite,
                    onChanged: (value) => tras.searchTransactions(value),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  GetBuilder<TransactionController>(
                    builder: (trans) {
                      if (trans.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (trans.transactions.isEmpty) {
                        return CustomEmplyScreen(
                          img: "assets/animations/empty.json",
                          content: "Oh Sorry , No Transaction Found 55",
                        );
                      }
                      return trans.filteredTransactions.isNotEmpty
                          ? AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: trans.filteredTransactions.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ReusableListViewAnimation(
                                    index: index,
                                    widget: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: TransactionCard(
                                        transaction:
                                            trans.filteredTransactions[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : CustomEmplyScreen(
                              img: "assets/animations/empty.json",
                              content: "Oh Sorry , No Transaction Found",
                            );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(builder: (trs) {
      return GestureDetector(
        onTap: () {
          Get.to(
            () => TransactionDetailsScreen(
              transaction: transaction,
            ),
            fullscreenDialog: true,
            transition: Transition.downToUp,
          );
        },
        child: ClipPath(
          clipper: CouponClipper(
            direction: Directionality.of(context),
            curvePosition: MediaQuery.of(context).size.width * 0.7,
            curveRadius: 40,
            curveAxis: Axis.vertical,
          ),
          child: Container(
            //margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Get.isDarkMode
                      ? AppColor.kSecondDarkColor
                      : Colors.black45.withOpacity(0.1),
                  width: 1),
              boxShadow: [
                Get.isDarkMode
                    ? BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${moneyFormater(double.parse(transaction.totalAmount.toString())).compactSymbolOnLeft}",
                        style: TextStyle(
                          fontSize: 13,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "${transaction.transactionTime}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor.withOpacity(0.75)
                                  : AppColor.kJtechPrimaryColor
                                      .withOpacity(0.75),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "-Receipt #${transaction.transactionId}",
                            style: TextStyle(
                              fontSize: 13,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor.withOpacity(0.75)
                                  : AppColor.kJtechPrimaryColor
                                      .withOpacity(0.75),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${transaction.transactionDate}", //Monday , 15 January 2024
                        style: TextStyle(
                          fontSize: 15,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          trs.getBackgroundColor(transaction.status.toString()),

                      // transaction.paymentMethod == 'Cash'
                      //     ? Color(0xff00D27B)
                      //     : transaction.paymentMethod == 'Credit'
                      //         ? Color(0xfff68e57)
                      //         : Color(0xff00D27B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      // transaction.transactionType == 'Cash'
                      //     ? "Paid"
                      //     : transaction.transactionType == 'Credit'
                      //         ? "Credit"
                      //         : "Paid",

                      "${transaction.status}",
                      style: TextStyle(
                        fontSize: 14,
                        color: transaction.status == "Credit"
                            ? AppColor.kTexMoneyColor
                            : AppColor.kbgColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
