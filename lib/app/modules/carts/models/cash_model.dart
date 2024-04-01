import 'dart:developer';

import 'package:get/get.dart';

import '../views/payment_as_cash_page.dart';
import '../views/payment_method_as_credit_page.dart';

class CashModelServices {
  final String iconPath;
  final String title;
  final String paymentMethodType;
  bool isPaymentShow;

  final void Function()? onTap;
  CashModelServices({
    required this.iconPath,
    required this.title,
    this.onTap,
    required this.paymentMethodType,
    required this.isPaymentShow,
  });
}

List cashModelServices = [
  CashModelServices(
    paymentMethodType: "EVC",
    iconPath: "assets/images/wallet-3d.png",
    title: "Evc",
    onTap: () {
      log("EVC", name: "EVC Mobile app");
    },
    isPaymentShow: true,
  ),
  CashModelServices(
    iconPath: "assets/images/wallet-3d.png",
    title: "Cash",
    onTap: () => Get.to(
      () => PaymentAsCashScreen(
        paymentMethodType: "Cash",
      ),
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    paymentMethodType: "Cash",
    isPaymentShow: true,
  ),
  CashModelServices(
    iconPath: "assets/images/wallet-3d.png",
    title: "E-Wallet",
    onTap: () {
      log("E-Wallet", name: "E-Wallet Mobile app");
    },
    paymentMethodType: "E-Wallet",
    isPaymentShow: true,
  ),
  CashModelServices(
    iconPath: "assets/images/wallet-3d.png",
    title: "Credit",
    onTap: () => Get.to(
      () => PaymentMethodAsCreditPage(
        paymentMethodType: "Credit",
        isCredit: true,
      ),
      fullscreenDialog: true,
      transition: Transition.rightToLeftWithFade,
    ),
    paymentMethodType: "Credit",
    isPaymentShow: true,
  ),
  CashModelServices(
    iconPath: "assets/images/wallet-3d.png",
    title: "Bank",
    onTap: () {
      log("E-Bank", name: "E-Bank Mobile app");
    },
    paymentMethodType: "Bank",
    isPaymentShow: true,
  ),
];

// class CashModelServices {
//   String? title;
//   String? paymentMethodType;
//   String? iconPath;
//   bool? isPaymentShow;

//   CashModelServices(
//       {this.title, this.paymentMethodType, this.iconPath, this.isPaymentShow});

//   CashModelServices.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     paymentMethodType = json['paymentMethodType'];
//     iconPath = json['iconPath'];
//     isPaymentShow = json['isPaymentShow'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['paymentMethodType'] = this.paymentMethodType;
//     data['iconPath'] = this.iconPath;
//     data['isPaymentShow'] = this.isPaymentShow;
//     return data;
//   }
// }
