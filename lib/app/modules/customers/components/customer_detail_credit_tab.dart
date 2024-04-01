import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';

import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';
import '../controllers/customers_controller.dart';
import 'add_customer_textfields.dart';

class CustomThirdCreditDataTab extends StatelessWidget {
  const CustomThirdCreditDataTab({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CustomersController>(
        builder: (cus) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show and Hidding Credit Allowance
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Credit Allowance",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.center,
                    // scaleX: 0.8,
                    // scaleY: 0.8,
                    child: Switch(
                      value: cus.isCustomerCreditAllowance,
                      onChanged: (bool value) =>
                          cus.updateIsCreditAllowanceTextFeilds(value),
                      //activeColor: AppColor.kbgColor,

                      activeTrackColor: AppColor.kTexMoneyColor,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Visibility(
                visible: cus.isCustomerCreditAllowance,
                // customer.credit > 0
                //     ? true
                //     :
                child: Column(
                  children: [
                    AddCustomerTextFeilds(
                      labeText: "Customer Credit Amount",
                      controller: cus.customerAllowanceCreditController
                        ..text = customer.credit.toString(),
                      iconData: CupertinoIcons.money_dollar,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    AddCustomerTextFeilds(
                      labeText: "Suttelement Period(Days)",
                      controller: cus.customerAllowanceSettlementsDayController
                        ..text = customer.suttlementDays.toString(),
                      iconData: IconlyBroken.discovery,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SignInBtn(
                  text: "Apply",
                  onPressed: () {},
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.2),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Get.isDarkMode
                      ? Theme.of(context).cardColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffF68E57),
                        ),
                        child: Text(
                          "Suspend Account",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kbgColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffF25369),
                        ),
                        child: Text(
                          "Delete Customer",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kbgColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
