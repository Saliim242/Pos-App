import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';

import '../../../../constants/constants.dart';
import '../models/cash_model.dart';
import 'manage_payment_mothods_page.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({super.key});

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
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
            'Cash Out',
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => ManagePaymentMethodsPage(),
                fullscreenDialog: true,
                transition: Transition.upToDown,
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColor.kJtechSecondColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.dollar_circle,
                    size: 20,
                    color: AppColor.kbgColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Manage",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.kbgColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<CartsController>(builder: (cashout) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Stack(
                // fit: StackFit.passthrough,
                children: [
                  Positioned(
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColor.kJtechSecondColor,
                        // Get.isDarkMode
                        //     ? AppColor.kSecondDarkColor
                        //     : AppColor.kJtechPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 18),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Theme.of(context).cardColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        Get.isDarkMode
                            ? BoxShadow()
                            : BoxShadow(
                                color: AppColor.kJtechPrimaryColor
                                    .withOpacity(0.2),
                                offset: Offset(1, 1),
                                blurRadius: 1,
                              )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 18,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        Text(
                          "${moneyFormater(cashout.totalPrice).compactSymbolOnLeft}",
                          style: TextStyle(
                            fontSize: 30,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// Payment Methods

              SizedBox(height: 20),
              GetBuilder<CartsController>(
                builder: (crt) {
                  // if (crt.isPaymentIsLoading) {
                  //   return Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // } else if (crt.cashesMethods.isEmpty) {
                  //   return Center(
                  //     child: Text("No Payment Methods founded"),
                  //   );
                  // }
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 375),
                    child: AnimationLimiter(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cashModelServices.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 375),
                          columnCount: cashModelServices.length,
                          position: index,
                          child: ScaleAnimation(
                            delay: const Duration(milliseconds: 200),
                            // horizontalOffset: 50,
                            // verticalOffset: 50.0,
                            child: ScaleAnimation(
                              delay: const Duration(milliseconds: 300),
                              child: PaymentMethodsCard(
                                cash: cashModelServices[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class PaymentMethodsCard extends StatelessWidget {
  PaymentMethodsCard({
    super.key,
    required this.cash,
  });

  final CashModelServices cash;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cash.onTap,
      child: Visibility(
        visible: cash.isPaymentShow, //cash.isPaymentShow!,
        child: Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              Get.isDarkMode
                  ? BoxShadow()
                  : BoxShadow(
                      color: AppColor.kJtechPrimaryColor.withOpacity(0.2),
                      offset: Offset(1, 1),
                      blurRadius: 1,
                    )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "${cash.iconPath}",
                height: 90,
              ),
              Text(
                "${cash.title}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
