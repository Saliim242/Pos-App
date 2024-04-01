import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';

import '../../../../constants/constants.dart';
import '../../carts/views/payment_method_as_credit_page.dart';
import '../../components/custom_error_screens.dart';
import '../../components/custom_list_view_animation.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../transaction/views/transaction_view.dart';

class CustomerSecondTransactionData extends StatelessWidget {
  const CustomerSecondTransactionData({
    super.key, required this.cus,
  });

  final CustomerModel cus;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<TransactionController>(builder: (tras) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchbleTextFeilds(
              controller: tras.transactionController,
              text: "Search Transactions You Need!",
              icon: Iconsax.search_favorite,
              onChanged: (value) {}, //tras.searchTransactions(value),
            ),
            SizedBox(height: 16),
            Text(
              "Latest Transactions",
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            cus.credit > 0
                ? GetBuilder<TransactionController>(
                    builder: (trans) {
                      if (trans.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (trans.transactions.isEmpty) {
                        return CustomEmplyScreen(
                          img: "assets/animations/empty.json",
                          content: "Oh Sorry , No Transaction Found",
                        );
                      }
                      return trans.filteredTransactions.isNotEmpty
                          ? AnimationLimiter(
                              child: ListView.builder(
                                //padding: EdgeInsets.all(_w / 30),
                                itemCount: trans.filteredTransactions.length,
                                shrinkWrap: true,
                                // physics: BouncingScrollPhysics(
                                //     parent: AlwaysScrollableScrollPhysics()),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
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
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          "assets/animations/empty.json",
                          animate: true,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Oh Sorry , No Transaction Found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
