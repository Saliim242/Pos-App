import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';

import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';

import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';
import 'add_customer_textfields.dart';

class CustomersTab extends StatefulWidget {
  const CustomersTab({Key? key}) : super(key: key);

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
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
            'Add New Customer',
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
      body: SafeArea(child: GetBuilder<CustomersController>(
        builder: (cus) {
          return Form(
            key: cus.addCustomerKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  //Hey there, new friend! Welcome to JTech Point of Sale Management . We can't wait for you to explore all our incredible features!
                  Text(
                    "Personal Details",
                    style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    //textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  AddCustomerTextFeilds(
                    labeText: "Enter Customer Name",
                    controller: cus.customerNameController,
                    iconData: IconlyBroken.profile,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AddCustomerTextFeilds(
                    labeText: "Enter Customer Phone Number",
                    controller: cus.customerPhoneNumberController,
                    iconData: IconlyBroken.call,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AddCustomerTextFeilds(
                    labeText: "Enter Customer Email",
                    controller: cus.customerEmailController,
                    iconData: IconlyBroken.message,
                    isEmail: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AddCustomerTextFeilds(
                    labeText: "Enter Customer Address",
                    controller: cus.customerAddressController,
                    iconData: IconlyBroken.location,
                    keyboardType: TextInputType.streetAddress,
                  ),

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
                          value: cus.showAddCreditTextField,
                          onChanged: (bool value) =>
                              cus.updateShowCreditTextFeilds(value),
                          //activeColor: AppColor.kbgColor,

                          activeTrackColor: AppColor.kTexMoneyColor,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: cus.showAddCreditTextField,
                    child: Column(
                      children: [
                        AddCustomerTextFeilds(
                          labeText: "Enter Customer Credit Amount",
                          controller: cus.customerCreditController,
                          iconData: CupertinoIcons.money_dollar,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        AddCustomerTextFeilds(
                          labeText: "Enter Suttelement Period(Days)",
                          controller: cus.customerSettlementsDayController,
                          iconData: IconlyBroken.discovery,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Use it to specific the period allowed between the transaction date and the settlement date you want.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor.withOpacity(0.75)
                                : AppColor.kJtechPrimaryColor.withOpacity(0.75),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Ends Show and Hidding for Credit Allowance

                  // Show and Hidding Gaurantor Informatino

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Gaurantor Information",
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
                          value: cus.showAddGaurantorTextField,
                          onChanged: (bool value) =>
                              cus.showAddGaurantorTextFields(value),
                          activeTrackColor: AppColor.kTexMoneyColor,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: cus.showAddGaurantorTextField,
                    child: Column(
                      children: [
                        AddCustomerTextFeilds(
                          labeText: "Enter Guarantor Full Name",
                          controller: cus.damiinkaMagacisaController,
                          iconData: IconlyBroken.profile,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        AddCustomerTextFeilds(
                          labeText: "Enter Guarantor Phone Number",
                          controller: cus.damiinkaPhoneNumberController,
                          iconData: IconlyBroken.call,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),
                  SignInBtn(
                    text: "Add Customer",
                    onPressed: () {
                      cus.addNewCustomer(context);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}


















/*  Gender Selection


 Text(
                    "Select The Gender",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Gender>(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade400.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(
                            Gender.Male.name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                          value: Gender.Male,
                          groupValue: cus.newGen,
                          onChanged: (value) => cus.updateGender(value),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      Expanded(
                        child: RadioListTile<Gender>(
                          contentPadding: EdgeInsets.all(0),
                          tileColor: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade400.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          title: Text(
                            Gender.Female.name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                          value: Gender.Female,
                          groupValue: cus.newGen,
                          onChanged: (value) {
                            cus.updateGender(value);
                          },
                        ),
                      ),
                    ],
                  ),


*/