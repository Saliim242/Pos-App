import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_manangement_app/app/modules/carts/views/success_payment_screen.dart';
import 'package:pos_manangement_app/app/modules/components/custom_list_view_animation.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';
import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';
import '../../../../constants/constants.dart';
import '../../transaction/views/transaction_view.dart';
import '../controllers/customers_controller.dart';
import '../views/customers_details_page.dart';

class CustomarFirstSummaryData extends StatelessWidget {
  const CustomarFirstSummaryData({
    super.key,
    required this.customer,
  });

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CustomersController>(builder: (cus) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Credit Summary",
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                //height: 300,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Theme.of(context).cardColor //AppColor.kThirdDarkColor
                      : Colors.white, //AppColor.kbgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Get.isDarkMode
                        ? AppColor.kJtechPrimaryColor
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    CreditSummaryListTileWidget(
                      color: Colors.indigoAccent,
                      title: "Credit Allowance",
                      trailing: customer.credit,
                      textColor: Colors.indigoAccent,
                      // Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor
                    ),
                    CreditSummaryListTileWidget(
                      color: Colors.deepOrange, //Color(0xfff68e57)
                      title: "Used Credit",
                      trailing: cus.usedCredit,
                      textColor: Colors.deepOrange,
                    ),
                    CreditSummaryListTileWidget(
                      color: Color(0xff00D27B),
                      title: "Availbale Credit",
                      trailing: cus.AvailbaleCredit == 0
                          ? customer.credit
                          : cus.AvailbaleCredit,
                      textColor: Color(0xff00D27B),
                    ),
                    ListTile(
                      //dense: true,
                      minVerticalPadding: 0,
                      //minLeadingWidth: 0,
                      horizontalTitleGap: 1,
                      leading: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(
                              0xfff68e57), //Color.fromARGB(255, 28, 42, 28),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(
                        "Credit Due Date",
                        style: TextStyle(
                          fontSize: 13,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          text: "${customer.suttlementDays}/ ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xfff68e57),
                            // Get.isDarkMode
                            //     ? AppColor.kbgColor
                            //     : AppColor.kJtechPrimaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: "Day",
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor.withOpacity(0.85)
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.85),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
            customer.credit > 0
                ? GetBuilder<TransactionController>(
                    builder: (trans) {
                      return AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: trans.transactions.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ReusableListViewAnimation(
                              index: index,
                              widget: Container(
                                margin: EdgeInsets.only(bottom: 12),
                                child: TransactionCard(
                                  transaction: trans.transactions[index],
                                ),
                              ),
                            );
                          },
                        ),
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
