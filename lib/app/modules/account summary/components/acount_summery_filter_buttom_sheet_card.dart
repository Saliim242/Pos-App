import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';
import '../controllers/account_summary_controller.dart';
import 'date_range_picker.dart';

class FilteredDataCard extends StatelessWidget {
  const FilteredDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountSummaryController>(builder: (acs) {
      return Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? const Color(0xff181D2D)
              : Colors.white, // Set Container background color to white

          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 16),
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     height: 5,
              //     width: 65,
              //     decoration: BoxDecoration(
              //       color: Colors.blue,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filter and Reset
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filter By",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? AppColor.kSecondDarkColor
                                : Color(0xffEAF4FD),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 15,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kTexMoneyColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Wrap(
                      //spacing: 10,
                      direction: Axis.horizontal,
                      children: acs.filteredDays
                          .map(
                            (i) => GestureDetector(
                              onTap: () =>
                                  acs.updateFilterType(i), //acs.filterType = i,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? AppColor.kSecondDarkColor
                                      : AppColor.kTexMoneyColor
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 0.95,
                                    color: acs.filterType == i
                                        ? Colors.blueAccent.withOpacity(0.65)
                                        : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  "${i}",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    Text(
                      "Choose Period",
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    GetBuilder<AccountSummaryController>(
                      builder: (crs) {
                        return Row(
                          children: [
                            Expanded(
                              child: DateRangePicker(
                                title: "Start Date",
                                onTap: () {
                                  crs.chooseDateRange(context);
                                },
                                dateRange: DateFormat('dd-MMM-yyyy').format(
                                  crs.dateRange.start,
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
                            Expanded(
                              child: DateRangePicker(
                                title: "End Date",
                                onTap: () => crs.chooseDateRange(context),
                                dateRange: DateFormat('dd-MMM-yyyy').format(
                                  crs.dateRange.end,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    SizedBox(
                      child: SignInBtn(
                        text: "Apply Filtered",
                        onPressed: () => acs.applayFilteredData(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
