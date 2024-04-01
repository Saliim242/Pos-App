import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/shimmer_effect_widget.dart';
import '../../components/custom_error_screens.dart';
import '../../customers/components/customer_credit_cards.dart';
import '../../customers/components/customers_tab.dart';

class PaymentMethodAsCreditPage extends StatelessWidget {
  const PaymentMethodAsCreditPage(
      {super.key, required this.paymentMethodType, required this.isCredit});

  final String paymentMethodType;
  final bool isCredit;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersController>(builder: (COS) {
      return RefreshIndicator(
        onRefresh: () => COS.loadCustomers(),
        child: Scaffold(
          appBar: AppBar(
            elevation: Get.isDarkMode ? 0.5 : 0.5,
            backgroundColor: //Theme.of(Get.context!).primaryColor,
                Get.isDarkMode
                    ? Theme.of(Get.context!).cardColor
                    : Colors.grey.shade100,
            centerTitle: true,
            title: Marquee(
              child: Text(
                'Client Credit list',
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
            builder: (credit) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Column(
                      children: [
                        GetBuilder<CustomersController>(builder: (custCredit) {
                          return Row(
                            children: [
                              Expanded(
                                child: SearchbleTextFeilds(
                                  icon: Iconsax.search_favorite,
                                  controller:
                                      custCredit.creditCustomerSearchController,
                                  onChanged: (query) => custCredit
                                      .searchCustomerNameWithCredit(query),
                                  text: "Search By Name or telephone or email",
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        // Displaying All Ower Customers

                        GetBuilder<CustomersController>(
                          builder: (cus) {
                            if (cus.isCustomerLoading) {
                              return ShimmerWidget();
                            } else if (cus.customers.isEmpty) {
                              return Center(
                                child: CustomEmplyScreen(
                                  content:
                                      "Their is no customers found with available credit.",
                                  img: "assets/animations/empty.json",
                                ),
                              );
                            }

                            return cus
                                    .filteredCustomers
                                    // .where((customer) => customer.credit > 0)
                                    // .toList()
                                    .isNotEmpty
                                ? AnimatedContainer(
                                    duration: Duration(milliseconds: 375),
                                    child: AnimationLimiter(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: cus
                                            .filteredCustomers
                                            // .where((customer) => customer.credit > 0)
                                            // .toList()
                                            .length,
                                        itemBuilder: (context, index) =>
                                            AnimationConfiguration
                                                .staggeredList(
                                          duration:
                                              const Duration(milliseconds: 375),
                                          position: index,
                                          child: ScaleAnimation(
                                            delay: const Duration(
                                                milliseconds: 200),
                                            // horizontalOffset: 50,
                                            // verticalOffset: 50.0,
                                            child: SlideAnimation(
                                              delay: const Duration(
                                                  milliseconds: 300),
                                              child: CustomersCardWidget(
                                                model: cus
                                                    .filteredCustomers[index],
                                                onTap: () {
                                                  cus.showChargeCreditDialog(
                                                    credit.totalPrice,
                                                    cus.filteredCustomers[
                                                        index],
                                                    paymentMethodType,
                                                    isCredit,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CustomEmplyScreen(
                                      content:
                                          "Their is no customers found with available credit.",
                                      img: "assets/animations/empty.json",
                                    ),
                                  );
                          },
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: SignInBtn(
                            text: "Add New Customer",
                            onPressed: () {
                              Get.to(
                                () => CustomersTab(),
                                fullscreenDialog: true,
                                transition: Transition.downToUp,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class SearchbleTextFeilds extends StatelessWidget {
  const SearchbleTextFeilds({
    super.key,
    required this.controller,
    required this.text,
    this.onChanged,
    required this.icon,
  });

  final TextEditingController controller;
  final String text;
  final void Function(String)? onChanged;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 15,
        color: Get.isDarkMode
            ? AppColor.kbgColor.withOpacity(0.6)
            : AppColor.kJtechPrimaryColor,
      ),
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.all(18),
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Get.isDarkMode ? Colors.grey.shade200 : Colors.grey,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1),
        ),
        focusedBorder: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColor.kJtechPrimaryColor,
            width: 1,
          ),
        ),

        hintText: "${text}",
        hintStyle: TextStyle(
          fontSize: 14,
          color: Get.isDarkMode
              ? Colors.grey.shade300.withOpacity(0.6)
              : AppColor.kJtechPrimaryColor.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          icon,
          size: 24,
          color: Get.isDarkMode
              ? AppColor.kbgColor.withOpacity(0.6)
              : AppColor.kJtechPrimaryColor,
        ),
      ),
    );
  }
}
