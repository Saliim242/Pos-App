import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import '../../../../constants/constants.dart';
import '../components/custom_detail_profile_tab.dart';
import '../components/customer_detail_credit_tab.dart';
import '../components/customer_detail_summery_tab.dart';
import '../components/customer_detail_transaction_tab.dart';
import '../models/customer_model.dart';

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key, required this.customer});
  final CustomerModel customer;

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Colors.grey.shade100,
        // centerTitle: true,
        title: Marquee(
          child: Text(
            '${widget.customer.customerName}',
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                // All Tabs
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColor.kThirdDarkColor
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(
                      4.0,
                    ),
                  ),
                  child: TabBar(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    labelPadding: EdgeInsets.symmetric(horizontal: 0),
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                          text: 'Summary',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Tab(
                          text: 'Transactions',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Tab(
                          text: 'Credit',
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Tab(
                          text: 'Profile',
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      //====================================== First Summery Credit Data And Transaction =====================================
                      CustomarFirstSummaryData(customer: widget.customer),
                      // ================================== Second Tap (Transaction) Transaction Data =====================================
                      CustomerSecondTransactionData(cus: widget.customer),
                      // ================================== Third Tap (Credit) Transaction Data =========================================
                      CustomThirdCreditDataTab(customer: widget.customer),
                      // ================================== Four Tap (Customer Profile Data) Transaction Data =========================================
                      CustomFourProfileDataTab(customer: widget.customer),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CreditSummaryListTileWidget extends StatelessWidget {
  const CreditSummaryListTileWidget({
    super.key,
    required this.color,
    required this.title,
    required this.trailing,
    required this.textColor,
  });

  final Color color;
  final String title;
  final double trailing;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //dense: true,
      minVerticalPadding: 0,
      //minLeadingWidth: 0,
      horizontalTitleGap: 1,
      leading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        "${title}",
        style: TextStyle(
          fontSize: 14,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
      ),
      trailing: Text(
        "${moneyFormater(trailing).compactSymbolOnLeft}",
        style: TextStyle(
          fontSize: 15,
          color: textColor,
        ),
      ),
    );
  }
}

/*
ListTile(
      //dense: true,
      minVerticalPadding: 0,
      //minLeadingWidth: 0,
      horizontalTitleGap: 1,
      leading: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        "${title}",
        style: TextStyle(
          fontSize: 14,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
      ),
      trailing: Text(
        "${moneyFormater(trailing).compactSymbolOnLeft}",
        style: TextStyle(
          fontSize: 14,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
      ),
    )



*/
