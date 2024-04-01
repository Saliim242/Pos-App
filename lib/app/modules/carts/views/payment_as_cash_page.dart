import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';

import '../../../../constants/constants.dart';
import '../components/add_discount_textfield.dart';

class PaymentAsCashScreen extends StatelessWidget {
  const PaymentAsCashScreen({super.key, required this.paymentMethodType});

  final String paymentMethodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Colors.grey.shade100,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Payment as cash',
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
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<CartsController>(
        builder: (cash) {
          cash.paymentMethodType = paymentMethodType;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Theme.of(context).cardColor
                            : AppColor.kJtechShadowColor,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                          Text(
                            "${moneyFormater(cash.totalPrice).compactSymbolOnLeft}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kTexMoneyColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      padding: EdgeInsets.all(12),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Theme.of(context).cardColor
                            : AppColor.kJtechShadowColor,
                        border: Border.all(
                          color: Get.isDarkMode
                              ? AppColor.kJtechShadowColor.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AddDiscountTextFeild(
                            // iconData: Icons.monetization_on_outlined,
                            textAlign: TextAlign.center,
                            controller: cash.paymentMethodAsCashController,
                            hintText: "0",
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                          Text(
                            "Collected Amount",
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.wallet, size: 20),
                        //SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            cash.exactAmoutDisplays();
                          },
                          child: Text(
                            "EXACT AMOUNT",
                            style: TextStyle(
                              fontSize: 15,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Visibility(
                      visible: cash.canOrderCompeleted,
                      child: Text(
                        "The entred amount is less than total bill",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.kTexMoneyColor,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    SignInBtn(
                      text: "Complete Oreder",
                      onPressed: () {
                        cash.canOrdersCompeleted();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
