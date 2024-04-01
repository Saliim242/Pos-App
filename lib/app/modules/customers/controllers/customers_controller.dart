import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pos_manangement_app/app/modules/carts/views/success_payment_screen.dart';
import 'package:pos_manangement_app/app/modules/components/custom_list_view_animation.dart';
import 'package:pos_manangement_app/app/modules/customers/models/customer_model.dart';
import 'package:pos_manangement_app/app/modules/customers/providers/customer_provider.dart';
import 'package:pos_manangement_app/app/modules/customers/views/customers_details_page.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import 'package:pos_manangement_app/constants/display_message_errors.dart';

import '../components/customer_credit_cards.dart';
import '../components/display_error_credit_methods.dart';

enum Gender { Male, Female }

class CustomersController extends GetxController {
  final GlobalKey<FormState> addCustomerKey = GlobalKey<FormState>();
  Gender? newGen;
  List<CustomerModel> customers = [];
  List<CustomerModel> filteredCustomers = [];
  List<CustomerModel> filteredAllCustomers = [];
  List<CustomerModel> filteredCustomersWithCredit = [];
  bool isCustomerLoading = false;

  // All Text Controllers Of Adding New Customers
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerPhoneNumberController =
      TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController creditCustomerSearchController =
      TextEditingController();
  final TextEditingController searchAllCustomerController =
      TextEditingController();
  final TextEditingController searchCustomersWithAllCreditController =
      TextEditingController();

  // Credit and Guarantor TextEditors
  final TextEditingController customerCreditController =
      TextEditingController(text: double.parse("${0}").toString());
  final TextEditingController customerSettlementsDayController =
      TextEditingController(text: "Defualt:  30 Days");
  // Damiinka Xogtiisa
  final TextEditingController damiinkaMagacisaController =
      TextEditingController(text: "");
  final TextEditingController damiinkaPhoneNumberController =
      TextEditingController(text: "");

  //===================

  // Load All Our Customers Function
  loadCustomers() async {
    try {
      isCustomerLoading = true;
      update();
      // if (customers.isEmpty) {
      //   isCustomerLoading = true;
      //   update();
      // }

      await Future.delayed(Duration(seconds: 2));

      customers = await CustomerProvider().getCustomers();

      update();
    } catch (e) {
      print("Customers are ${customers.toString()}");
      customers = [];

      update();

      Logger().e("Load Customers error", error: e.toString());
    } finally {
      isCustomerLoading = false;
      update();
    }
  }

  // Getting All Custometrs Who Have Credit Balance With No-Zero
  // customersWithCredit =
  //       customers.where((customer) => customer.credit > 0).toList();

  // Email Validation
  bool isEmailValid(String email) {
    String emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  // Update Gender Value to New Value
  void updateGender(Gender? value) {
    newGen = value;
    update();

    log("The Gender Value is ${newGen!.name}");
  }

  // Add New Customer To Our Database Backend
  void addNewCustomer(BuildContext context) {
    if (addCustomerKey.currentState!.validate()) {
      if (newGen != null) {
        showSnackBars(
          context: context,
          title: "Adding New Customer",
          message: "Successsfully Added New Customer",
          contentType: ContentType.success,
        );
      } else {
        showSnackBars(
          context: context,
          title: "Oops! pick Your Gender",
          message:
              "Forgot to select your gender? Please choose either 'Male' or 'Female' to proceed with the registration.",
          contentType: ContentType.failure,
        );
      }
    } else {
      showSnackBars(
        context: context,
        title: "Uh-oh!",
        message:
            "Some fields are missing. Fill in all required information to complete registration.",
        contentType: ContentType.failure,
      );
    }
  }

  /// ############################## Search Customers With Credit By its Full Name ################################### ///

  void searchCustomerNameWithCredit(String query) {
    // Update the filteredCustomers list based on the search query
    filteredCustomers = customers
        .where(
          (element) =>
              (element.customerName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  element.customerPhone
                      .toLowerCase()
                      .contains(query.toLowerCase())) &&
              element.credit > 0,
        )
        .toList();

    update();
  }

  // Search Customer Credits In The Customer Screen Page
  void searchCustomersWithCreditInCustomerPage(String query) {
    filteredCustomersWithCredit = customers
        .where(
          (element) =>
              (element.customerName
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  element.customerPhone
                      .toLowerCase()
                      .contains(query.toLowerCase())) &&
              element.credit > 0,
        )
        .toList();

    update();
  }

  /// ############################## Search All Customers With Credit or not have Credit ################################### /

  void searchAllCustomersWhoHaveCreditOrNot(String query) {
    filteredAllCustomers = customers
        .where(
          (element) =>
              element.customerName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element.customerPhone.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    update();
  }

  // Show and Hide TextFeilds Using switch
  bool showAddCreditTextField = false;
  bool showAddGaurantorTextField = false;

  void updateShowCreditTextFeilds(bool value) {
    showAddCreditTextField = value;
    update();
  }

  void showAddGaurantorTextFields(bool value) {
    showAddGaurantorTextField = value;
    update();
  }

  //=== End  Show and Hide TextFeilds Using switch =============================
  void printFiltter() {
    log("Customers ${filteredCustomers.length}");
  }

  @override
  void onInit() async {
    await loadCustomers();
    filteredAllCustomers = customers;
    filteredCustomersWithCredit =
        customers.where((customer) => customer.credit > 0).toList();
    filteredCustomers =
        customers.where((customer) => customer.credit > 0).toList();

    super.onInit();
  }

  @override
  void onClose() {
    customerNameController.dispose();
    customerAddressController.dispose();
    customerEmailController.dispose();
    customerPhoneNumberController.dispose();
    creditCustomerSearchController.dispose();
    damiinkaMagacisaController.dispose();
    damiinkaPhoneNumberController.dispose();
    searchCustomersWithAllCreditController.dispose();
    searchAllCustomerController.dispose();
    customerAllowanceCreditController.dispose();
    customerAllowanceSettlementsDayController.dispose();
    displayCustomerAddressController.dispose();
    displayCustomerEmailController.dispose();
    displayCustomerFullNameController.dispose();
    displayCustomerPhoneNumberController.dispose();
    displayCustomergaurantorPhoneController.dispose();
    displayCustomergaurantorNameController.dispose();
    super.onClose();
  }

  // Kudalicid Customer ka As Credit Ahaan Hdii UU Heesto
  void showChargeCreditDialog(
      double total, CustomerModel cus, String paymentType, bool isCredit) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            'Charge Customer',
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          content: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Are you sure you  want to charge ',
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
              children: [
                TextSpan(
                  text: "${cus.customerName} ",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.kJtechSecondColor,
                    fontFamily: 'Metrophobic',
                  ),
                ),
                TextSpan(
                    text: "with ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    )),
                TextSpan(
                  text: "${moneyFormater(total).compactSymbolOnLeft}",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.kJtechSecondColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: DisplayErrorContainerCredit(
                    text: "No",
                    bgColor: AppColor.kJtechSecondColor.withOpacity(0.2),
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    fontColor: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechSecondColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DisplayErrorContainerCredit(
                    text: "Yes",
                    bgColor: Color(0xff50c878),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    fontColor: AppColor.kbgColor,
                  ),
                )
              ],
            ),
          ],
        );
      },
    ).then((result) {
      if (result == true) {
        checkPayment(total, cus, paymentType, isCredit);
      }
    });
  }

  ///// Customer Details
  double usedCredit = 0;
  double AvailbaleCredit = 0;

  void checkPayment(
    double total,
    CustomerModel cus,
    String paymentType,
    bool isCredit,
  ) {
    if (cus.credit >= total) {
      Get.to(
        () => SuccessfullyPaymentScreen(
            paymentMethod: paymentType, isCreditShow: isCredit),
      );

      //total -= cus.credit;

      log("Now The Credit Value is ${cus.credit - total} and the ");
      usedCredit = total;
      AvailbaleCredit = cus.credit - usedCredit;

      update();
    } else {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text(
            'Insufficient credit',
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'The Total amount exceeds the total Credit limit!',
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            DisplayErrorContainerCredit(
              bgColor: AppColor.kJtechSecondColor.withOpacity(0.2),
              text: "Cancel",
              onTap: () {
                Navigator.of(context).pop();
              },
              fontColor: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechSecondColor,
            ),
          ],
        );
      },
    );
  }

  /// ====================== End Dalacid Lacagta ================

  //// Customer ListView
  Widget buildCustomerListView(List<CustomerModel> customers) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: customers.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ReusableListViewAnimation(
              index: index,
              widget: CustomersCardWidget(
                model: customers[index],
                onTap: () {
                  Get.to(
                    () => CustomerDetailsPage(
                      customer: customers[index],
                    ),
                    fullscreenDialog: true,
                    transition: Transition.downToUp,
                  );
                },
              ));
        },
      ),
    );
  }

  /// Customers Who Have Credit And Don't Credit Allowance
  ///
  bool isCustomerCreditAllowance = true;
  bool isCustomerGuarantorInfo = true;
  // Credit and Guarantor TextEditors
  final TextEditingController customerAllowanceCreditController =
      TextEditingController(text: double.parse("${0}").toString());
  final TextEditingController customerAllowanceSettlementsDayController =
      TextEditingController(text: "Defualt:  30 Days");

  // Personal Information TextFeilds
  final TextEditingController displayCustomerFullNameController =
      TextEditingController();
  final TextEditingController displayCustomerPhoneNumberController =
      TextEditingController();
  final TextEditingController displayCustomerEmailController =
      TextEditingController();
  final TextEditingController displayCustomerAddressController =
      TextEditingController();
  final TextEditingController displayCustomergaurantorNameController =
      TextEditingController();
  final TextEditingController displayCustomergaurantorPhoneController =
      TextEditingController();

  void updateIsCreditAllowanceTextFeilds(bool value) {
    isCustomerCreditAllowance = value;
    update();
  }

  void updateIsCustomerGuarantorInfoTextFeilds(bool value) {
    isCustomerGuarantorInfo = value;
    update();
  }
}
