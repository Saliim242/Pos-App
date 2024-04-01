import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import '../../../../constants/constants.dart';
import '../controllers/customers_controller.dart';
import 'add_customer_textfields.dart';

class CustomFourProfileDataTab extends StatelessWidget {
  const CustomFourProfileDataTab({super.key, required this.customer});

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<CustomersController>(
        builder: (cus) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show Personal Information
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 16,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
                //textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AddCustomerTextFeilds(
                labeText: "Customer FullName",
                controller: cus.displayCustomerFullNameController
                  ..text = customer.customerName,
                iconData: IconlyBroken.profile,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AddCustomerTextFeilds(
                labeText: "Customer Phone Number",
                controller: cus.displayCustomerPhoneNumberController
                  ..text = customer.customerPhone,
                iconData: IconlyBroken.call,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AddCustomerTextFeilds(
                labeText: "Customer Email",
                controller: cus.displayCustomerEmailController
                  ..text = customer.customerEmail,
                iconData: IconlyBroken.message,
                isEmail: true,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AddCustomerTextFeilds(
                labeText: "Customer Address",
                controller: cus.displayCustomerAddressController
                  ..text = customer.customerAddress,
                iconData: IconlyBroken.location,
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                      value: cus.isCustomerGuarantorInfo,
                      onChanged: (bool value) =>
                          cus.updateIsCustomerGuarantorInfoTextFeilds(value),
                      activeTrackColor: AppColor.kTexMoneyColor,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Visibility(
                visible: cus.isCustomerGuarantorInfo,
                child: Column(
                  children: [
                    AddCustomerTextFeilds(
                      labeText: "Guarantor FullName",
                      controller: cus.displayCustomergaurantorNameController
                        ..text = customer.gaurantorName,
                      iconData: IconlyBroken.profile,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    AddCustomerTextFeilds(
                      labeText: "Guarantor Phone Number",
                      controller: cus.displayCustomergaurantorPhoneController
                        ..text = customer.gaurantorPhone,
                      iconData: IconlyBroken.call,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SignInBtn(
                  text: "Update",
                  onPressed: () {},
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          );
        },
      ),
    );
  }
}
