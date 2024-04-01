import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';

import '../../../../constants/constants.dart';
import '../components/add_discount_textfield.dart';

class AddDiscountPage extends StatefulWidget {
  const AddDiscountPage({super.key});

  @override
  State<AddDiscountPage> createState() => _AddDiscountPageState();
}

class _AddDiscountPageState extends State<AddDiscountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
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
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Add Discount',
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
      body: GetBuilder<CartsController>(builder: (dis) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.monetization_on_outlined),
                            SizedBox(width: 8),
                            Text(
                              "Amount",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Tab(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.percent_outlined),
                          SizedBox(width: 8),
                          Text(
                            "Percentage",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              // tab bar view here

              SizedBox(height: MediaQuery.of(context).size.width * 0.05),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Container(
                            padding: EdgeInsets.all(12),
                            height: 145,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Theme.of(context).cardColor
                                  : AppColor.kJtechShadowColor,
                              border: Border.all(
                                color: Get.isDarkMode
                                    ? AppColor.kJtechShadowColor
                                        .withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Please enter discount amount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Expanded( 
                                  child: AddDiscountTextFeild(
                                    iconData: Icons.monetization_on_outlined,
                                    controller: dis.amoutDiscount,
                                    hintText: "0",
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kTexMoneyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          SizedBox(
                            child: SignInBtn(
                              text: "Confirm",
                              onPressed: () {
                                log("Discount Monety ${dis.amoutDiscount.text.trim()}");
                                dis.DiscountByAmout();
                                dis.updateShowDiscount();
                                Get.back();
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    // second tab bar view widget
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Container(
                            padding: EdgeInsets.all(12),
                            height: 145,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Theme.of(context).cardColor
                                  : AppColor.kJtechShadowColor,
                              border: Border.all(
                                color: Get.isDarkMode
                                    ? AppColor.kJtechShadowColor
                                        .withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Please enter discount percentagae",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechPrimaryColor,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Expanded(
                                  child: AddDiscountTextFeild(
                                    iconData: Icons.percent_outlined,
                                    controller: dis.percentageDiscount,
                                    hintText: "0",
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kTexMoneyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          SizedBox(
                            child: SignInBtn(
                              text: "Confirm",
                              onPressed: () {
                                dis.DiscountByPercentage();
                                dis.updateShowDiscount();
                                log("Discount Percentage ${dis.percentageDiscount.text}");
                                Get.back();
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DiscountCards extends StatelessWidget {
  const DiscountCards({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  final void Function()? onTap;
  final String title;
  final Widget icon;
  // final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 40),
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.kJtechPrimaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 8),
            Text("${title}"),
          ],
        ),
      ),
    );
  }
}

//  SizedBox(
//                           child: SignInBtn(
//                             text: "Confirm",
//                             onPressed: () {
//                               crts.DiscountByPercentage();
//                               crts.updateShowDiscount();
//                               log("Discount Percentage ${crts.percentageDiscount.text}");
//                               Get.back();
//                             },
//                           ),
//                         )
