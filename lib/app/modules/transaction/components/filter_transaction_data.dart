import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';
import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';

class FilteredTransactionDataCard extends StatelessWidget {
  const FilteredTransactionDataCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(builder: (tran) {
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
                          "Filter By Transactions",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Wrap(
                      spacing: 10,

                      //runSpacing: 25,

                      children: tran.filterTransactionData
                          .map(
                            (i) => GestureDetector(
                              onTap: () => tran.updateFilterTransactionType(
                                  i), //acs.filterType = i,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      // tran.getBackgroundColor(
                                      //     i, tran.filterTransactionType),

                                      Get.isDarkMode
                                          ? AppColor.kSecondDarkColor
                                          : AppColor.kTexMoneyColor
                                              .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 0.95,
                                    color: tran.filterTransactionType == i
                                        ? Colors.blueAccent
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

                    SizedBox(
                      child: SignInBtn(
                        text: "Apply Filtered",
                        onPressed: () {
                          tran.filteredTransaction(tran.filterTransactionType);
                          //applayFilteredTransactionData();
                        },
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
