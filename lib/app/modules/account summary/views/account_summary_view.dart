

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../constants/constants.dart';
import '../components/acount_summery_filter_buttom_sheet_card.dart';

import '../controllers/account_summary_controller.dart';

class AccountSummaryView extends GetView<AccountSummaryController> {
  const AccountSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: Get.isDarkMode
            ? Theme.of(Get.context!).cardColor
            : Theme.of(Get.context!).scaffoldBackgroundColor,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Account Summary',
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
            Get.find<AccountSummaryController>().currentSummary = 0;
          },
          child: Icon(
            Iconsax.back_square,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        actions: [],
      ),
      body: GetBuilder<AccountSummaryController>(builder: (acs) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  // Categories Types
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      //physics: BouncingScrollPhysics(),
                      itemCount: acs.summary.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => acs.updateSummary(index),
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: acs.currentSummary == index
                                  ? AppColor.kJtechPrimaryColor
                                  : Get.isDarkMode
                                      ? AppColor.kSecondDarkColor
                                      : AppColor.kJtechShadowColor,
                              borderRadius: BorderRadius.circular(8),
                              border: acs.currentSummary == index
                                  ? null
                                  : Border.all(
                                      color: AppColor.kJtechPrimaryColor
                                          .withOpacity(0.5),
                                    ),
                            ),
                            child: Text(
                              "${acs.summary[index]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: acs.currentSummary == index
                                    ? AppColor.kbgColor
                                    : Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechPrimaryColor,

                                // Get.isDarkMode
                                //     ? AppColor.kbgColor
                                //     : AppColor.kJtechPrimaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 16),

                  // Show The Data FOr Today Button

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isDismissible: acs.dismi,
                        backgroundColor: Get.isDarkMode
                            ? const Color(0xff181D2D)
                            : Colors.white,
                        elevation: 0,
                        showDragHandle: true,
                        context: context,
                        builder: (BuildContext context) {
                          return FilteredDataCard();
                        },
                      );
                    },
                    child:
                        GetBuilder<AccountSummaryController>(builder: (data) {
                      return Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Color(0xffEAF4FD),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Get.isDarkMode
                                ? AppColor.kSecondDarkColor
                                : AppColor.kTexMoneyColor.withOpacity(0.5),
                          ),
                        ),
                        child: ListTile(
                          tileColor: Colors.transparent,
                          // contentPadding: EdgeInsets.all(0),
                          title: RichText(
                            text: TextSpan(
                              text: "Show data for ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: "${data.filterType}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kTexMoneyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          leading: Icon(
                            IconlyBroken.filter,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                            size: 25,
                          ),
                          trailing: Icon(
                            IconlyBroken.arrow_right_circle,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                            size: 25,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  acs.text[acs.currentSummary],
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
