import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/views/payment_method_as_credit_page.dart';
import 'package:pos_manangement_app/constants/focused_menu_holders.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/shimmer_effect_widget.dart';
import '../../components/custom_error_screens.dart';
import '../../login/widgets/signin_widget.dart';

import '../components/customers_tab.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GetBuilder<CustomersController>(builder: (cont) {
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
                'All Our Customers',
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
          body: GetBuilder<CustomersController>(
            builder: (cus) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? AppColor.kThirdDarkColor
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                      ),
                      child: TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 0),
                        indicatorColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                        unselectedLabelColor: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        labelColor: AppColor.kbgColor,
                        indicator: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColor.kSecondDarkColor
                              : AppColor.kJtechPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        tabs: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Tab(
                              text: 'All',
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Tab(
                              text: 'Customers With Credit',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // tab bar view here

                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),

                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        //controller: _tabController,
                        children: [
                          // first tab bar view widget
                          RefreshIndicator(
                            onRefresh: () async => cont.loadCustomers(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SearchbleTextFeilds(
                                    controller: cus.searchAllCustomerController,
                                    text:
                                        "Search By Name or telephone or email",
                                    icon: Iconsax.search_favorite,
                                    onChanged: (query) => cont
                                        .searchAllCustomersWhoHaveCreditOrNot(
                                            query),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Our Customers",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Get.isDarkMode
                                              ? AppColor.kbgColor
                                              : AppColor.kJtechPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${cus.customers.length}/${cus.customers.length}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Get.isDarkMode
                                              ? AppColor.kbgColor
                                              : AppColor.kJtechPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  GetBuilder<CustomersController>(
                                    builder: (cont) {
                                      if (cont.isCustomerLoading) {
                                        return ShimmerWidget();
                                      } else if (cont.customers.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              CustomEmplyScreen(
                                                content:
                                                    "Empty Customer List Please make sure the customer list is not empty before proceeding.",
                                                img:
                                                    "assets/animations/empty.json",
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    cont.loadCustomers(),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColor
                                                        .kJtechSecondColor,
                                                    elevation: 0),
                                                child: const Text(
                                                  "Refresh",
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return FocusedMenuHolders(
                                          child: cus.filteredAllCustomers
                                                  .isNotEmpty
                                              ? cus.buildCustomerListView(
                                                  cus.filteredAllCustomers,
                                                )
                                              : Center(
                                                  child: Column(
                                                    children: [
                                                      CustomEmplyScreen(
                                                        content:
                                                            "Their is no customers founded .",
                                                        img:
                                                            "assets/animations/empty.json",
                                                      ),
                                                      SizedBox(height: 20),
                                                      ElevatedButton(
                                                        onPressed: () => cont
                                                            .loadCustomers(),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .kJtechSecondColor,
                                                                elevation: 0),
                                                        child: const Text(
                                                          "Refresh",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // second tab bar view widget
                          RefreshIndicator(
                            onRefresh: () async => cont.loadCustomers(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SearchbleTextFeilds(
                                    controller: cus
                                        .searchCustomersWithAllCreditController,
                                    text:
                                        "Search By Name or telephone or email",
                                    icon: Iconsax.search_favorite,
                                    onChanged: (query) => cus
                                        .searchCustomersWithCreditInCustomerPage(
                                            query),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Our Customers",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Get.isDarkMode
                                              ? AppColor.kbgColor
                                              : AppColor.kJtechPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${cus.filteredCustomersWithCredit.length}/${cus.customers.length}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Get.isDarkMode
                                              ? AppColor.kbgColor
                                              : AppColor.kJtechPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.035,
                                  ),
                                  GetBuilder<CustomersController>(
                                    builder: (cont) {
                                      if (cont.isCustomerLoading) {
                                        return ShimmerWidget();
                                      } else if (cont.customers.isEmpty) {
                                        return Center(
                                          child: Column(
                                            children: [
                                              CustomEmplyScreen(
                                                content:
                                                    "Their is no customers found with available credit.",
                                                img:
                                                    "assets/animations/empty.json",
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    cont.loadCustomers(),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColor
                                                        .kJtechSecondColor,
                                                    elevation: 0),
                                                child: const Text(
                                                  "Refresh",
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return cus.filteredCustomersWithCredit
                                                .isNotEmpty
                                            ? FocusedMenuHolders(
                                                child:
                                                    cus.buildCustomerListView(
                                                  cus.filteredCustomersWithCredit,
                                                ),
                                              )
                                            : Center(
                                                child: Column(
                                                  children: [
                                                    CustomEmplyScreen(
                                                      content:
                                                          "Their is no customers found with available credit.",
                                                      img:
                                                          "assets/animations/empty.json",
                                                    ),
                                                    SizedBox(height: 20),
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          cont.loadCustomers(),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  AppColor
                                                                      .kJtechSecondColor,
                                                              elevation: 0),
                                                      child: const Text(
                                                        "Refresh",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

// @override
// Future<void> afterFirstLayout(BuildContext context) {
//   Get.find<CustomersController>().loadCustomers();
// }
