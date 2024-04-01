// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pos_manangement_app/app/modules/carts/models/cash_model.dart';
import 'package:pos_manangement_app/app/modules/carts/providers/cart_provider.dart';

import 'package:pos_manangement_app/app/modules/carts/views/success_payment_screen.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';
import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import '../../../data/product_model.dart';
import '../../customers/components/display_error_credit_methods.dart';

class CartsController extends GetxController {
  bool isListView = false;

  final isGrid = GetStorage();

  changeStudentType({required AnimationController studentController}) {
    if (isListView = !isGrid.read('getProductType')) {
      isGrid.write('getProductType', isListView);
      animateForward(true, rotationController: studentController);
      update();
    } else {
      isGrid.write('getProductType', isListView);
      animateForward(false, rotationController: studentController);
      update();
    }
  }

  void animateForward(bool animate,
      {required AnimationController rotationController}) {
    if (animate) {
      rotationController.forward(from: 0.0);
      update();
    } else {
      rotationController.reverse();
      update();
    }
  }

  List<CashModelServices> cashesMethods = [];
  bool isPaymentIsLoading = false;
  final TextEditingController amoutDiscount =
      TextEditingController(text: double.parse("${0}").toString());
  final TextEditingController percentageDiscount =
      TextEditingController(text: double.parse("${0}").toString());
  final TextEditingController paymentMethodAsCashController =
      TextEditingController(text: double.parse("${0}").toString());

  loadPaymentMethods() async {
    try {
      isPaymentIsLoading = true;
      update();
      // if (customers.isEmpty) {
      //   isCustomerLoading = true;
      //   update();
      // }

      await Future.delayed(Duration(seconds: 2));

      cashesMethods = await CartProvider().getPaymentMethods();

      update();
    } catch (e) {
      print("Customers are ${cashesMethods.toString()}");
      cashesMethods = [];

      update();

      Logger().e("Load Customers error", error: e.toString());
    } finally {
      isPaymentIsLoading = false;
      update();
    }
  }

  bool showDiscount = false;
  bool canOrderCompeleted = false;

  void updatePayment(bool value) {}

  void updateShowDiscount() {
    if (amoutDiscount.text.isNotEmpty && amoutDiscount.text != '0.0' ||
        percentageDiscount.text.isNotEmpty &&
            percentageDiscount.text != '0.0') {
      showDiscount = !showDiscount;
      update();
    } else {
      log("No Way Bro");
    }
  }

  double discountValues = 0.0;
  bool isAmoutOrPersentage = false;
  // Discount By Amount Cash Dollar
  void DiscountByAmout() {
    if (amoutDiscount.text.isNotEmpty && amoutDiscount.text != '0.0') {
      isAmoutOrPersentage = true;
      discountValues = double.parse(amoutDiscount.text);
      totalPrice -= double.parse(amoutDiscount.text);

      update();
    } else {
      log("Hooy Wx soo Gali Horta");
    }
  }

  // Discount By Amount Cash Dollar
  void DiscountByPercentage() {
    if (percentageDiscount.text.isNotEmpty &&
        percentageDiscount.text != '0.0') {
      isAmoutOrPersentage = false;
      discountValues = double.parse(percentageDiscount.text);
      double percentage = totalPrice -
          (totalPrice * double.parse(percentageDiscount.text) / 100);
      totalPrice = percentage;
      //double.parse(percentageDiscount.text);

      update();
    } else {
      log("Hooy Wx soo Gali Horta");
    }
  }

  // Displays Extac Aount On payment Method Cash
  void exactAmoutDisplays() {
    paymentMethodAsCashController.text = totalPrice.toString();
    update();
  }

  // canOrderCompeleted oN PAYMENT cASHOUT
  List<String> methods = [
    "EVC Plus",
    "Cash",
    "E-Wallet",
    "Credit",
    "Bank",
  ];

  double chargeAmount = 0.0;

  String paymentMethodType = '';

  final pr = Get.find<ProductsController>();
  final cs = Get.find<CustomersController>();
  final trasa = Get.put<TransactionController>(TransactionController());

  void canOrdersCompeleted() {
    if (paymentMethodAsCashController.text.isNotEmpty &&
        paymentMethodAsCashController.text != '0.0') {
      if (double.parse(paymentMethodAsCashController.text) < totalPrice) {
        canOrderCompeleted = true;
        update();
      } else {
        if (double.parse(paymentMethodAsCashController.text) >= totalPrice) {
          chargeAmount =
              double.parse(paymentMethodAsCashController.text) - totalPrice;
          update();
          Get.to(
            () => SuccessfullyPaymentScreen(
              paymentMethod: paymentMethodType,
              isCreditShow: false,
            ),
            fullscreenDialog: true,
            transition: Transition.rightToLeftWithFade,
          );
          log("Yes You have paid Successfully");

          //  trasa.addTransaction( )
        }
      }
    } else {
      showToast("Please enter The total amount of your items.");
    }
  }

  final List discountValue = [
    ["Amount", Icon(Icons.monetization_on_outlined)],
    ["Persentage", Icon(Icons.percent_outlined)],
  ];

  final box = GetStorage();
  final box2 = GetStorage();
  final String calculatingPrice = 'money';
  final String kCartsProducts = 'carts';
  double totalPrice = 0.0;
  final List<ProductModel> cartsProducts = [];
  final List<ProductModel> products = [];

  int get cartLength => cartsProducts.length;
  bool checkCartsInCart(ProductModel pro) {
    bool isCart = false;
    for (ProductModel item in cartsProducts) {
      if (item.id == pro.id) {
        isCart = true;
      }
    }
    return isCart;
  }

  Future<void> getcartsProducts() async {
    if (box.hasData(kCartsProducts)) {
      var data = await box.read(kCartsProducts);
      for (var v in data) {
        cartsProducts.add(
          ProductModel.fromJson(Map<String, dynamic>.from(v)),
        );
      }
      update();
    }
  }

  Future<void> removeCartItems(ProductModel pro) async {
    cartsProducts.removeWhere((e) => e.id == pro.id);

    final products = cartsProducts.map((v) => v.toJson()).toList();
    await box.remove(kCartsProducts);
    await box.write(kCartsProducts, products);
    totalPrice -= pro.price;
    await box2.write(calculatingPrice, totalPrice);

    update();

    //await box2.remove(calculatingPrice);
    log("Total ${box2.read(calculatingPrice)}");
  }

  Future<void> removeAllCartItems() async {
    // cartsProducts.removeWhere((e) => e.id == pro.id);
    cartsProducts.clear();

    final products = cartsProducts.map((v) => v.toJson()).toList();
    log("Data Is ${box.read(kCartsProducts)}");
    await box.remove(kCartsProducts);
    //await box.write(kCartsProducts, products);

    await box2.remove("${calculatingPrice}");
    totalPrice = 0.0;
    await box2.write(calculatingPrice, totalPrice);

    log("Wuuuuuu ${totalPrice} and ${box2.read(calculatingPrice)}");

    update();

    // await box2.remove(calculatingPrice);
    log("Total ${totalPrice} ");
  }

  Future<void> emptyCartWhenRemoves(ProductModel pro) async {
    log("Waaaa la wacay funtionka Nio");
    for (ProductModel item in cartsProducts) {
      if (item.id == pro.id) {
        // cartsProducts.removeWhere((e) => e.id == pro.id);
        totalPrice -= pro.price;
        await box2.write(calculatingPrice, totalPrice);
        update();
      }
      // if (item.id == pro.id) {
      //   totalPrice -= double.parse(pro.price.toString());
      //   update();
      //   //await box2.write(calculatingPrice, totalPrice);

      //   update();
      // } else {
      //   log("Waxaba kama Jari karno ", name: "Ahlaam");
      //   pro;
      // }
    }
  }

  final inc = GetStorage();
  // InCreament Quantenty
  void incrementQty(ProductModel pro, int index) async {
    for (ProductModel item in cartsProducts) {
      if (item.id == pro.id) {
        //(item.quantity += 1);
        item.quantity = item.quantity + 1;

        totalPrice += double.parse(item.price.toString());
        await box2.write(calculatingPrice, totalPrice);
        update();

        log("Items ${item.quantity} and ${item.price}");

        // item.quantity = (item.quantity! + 1);
        // log("Item Name : ${item.title} and Price ${item.price} and Qty ${item.quantity}");

        // update();
      } else {
        pro;
      }
    }
  }

  // Increment quantity for a product and add to total

  // InCreament Quantenty
  void decrementQty(ProductModel pro) async {
    for (ProductModel item in cartsProducts) {
      if (item.id == pro.id && item.quantity > 1) {
        //(item.quantity += 1);

        item.quantity = (item.quantity - 1);
        totalPrice -= double.parse(item.price.toString());
        await box2.write(calculatingPrice, totalPrice);
        update();

        update();
      } else {
        pro;
      }
    }

    log("Total Increment In Carts is ${pro.quantity}",
        name: "GETTING QUANTANTY");
  }

  //// Get quantity
  // int getQuantity() {
  //   return cartLength == 0
  //       ? 0
  //       : cartsProducts
  //           .map((e) => e.quantity)
  //           .reduce((value, element) => value + element);
  // }

  /// Calculate Total Price
  // Qaababka ku darso Total Amount

  sumCart() {
    return cartLength == 0
        ? 0.0
        : cartsProducts
            .map((e) => e.price * e.quantity)
            .reduce((value, element) => value + element);
  }

  ///
  Future<void> getcartsPrice(ProductModel pro) async {
    totalPrice += await double.parse(pro.price.toString()) * pro.quantity;
    log("Item Name : ${pro.title} and Price ${pro.price} and Qty ${pro.quantity}");

    await box2.write(calculatingPrice, totalPrice);

    update();

    log("Total Price In Carts is ${totalPrice}", name: "GETTING PRICE");
  }

  // Subtracting When Removing The Cart
  Future<void> getRemovedCartsPrice(ProductModel pro) async {
    //totalPrice -= await double.parse(pro.price.toString()) * pro.quantity;
    totalPrice -= await double.parse(pro.price.toString());
    log("Item Name : ${pro.title} and Price ${pro.price} and Qty ${pro.quantity}");
    update();
    await box2.write(calculatingPrice, totalPrice);

    log("Total Price In Carts is ${totalPrice}", name: "GETTING PRICE");
  }

  /// USer In An Ka Xaqiijino Inuu Donaayo Inuu Ka saaro Cart
  void showRemovingItemConfirmationDialog(
    ProductModel pro,
  ) {
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
              text: 'Are you sure you  want to Remove ',
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
              children: [
                TextSpan(
                  text: "${pro.title} ",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.kJtechSecondColor,
                    fontFamily: 'Metrophobic',
                  ),
                ),
                TextSpan(
                    text: "From Cart ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    )),
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
        removeCartItems(pro);
        getRemovedCartsPrice(pro);
      }
    });
  }

  // // Check Removing From The Cart
  // checkPayment(ProductModel pro) {
  //   removeCartItems(pro);
  //   getRemovedCartsPrice(pro);

  //   update();
  // }

  Future<void> saveCartsProducts(ProductModel pro) async {
    if (!cartsProducts.contains(pro)) {
      cartsProducts.add(pro);
      update();
      final products = cartsProducts.map((v) => v.toJson()).toList();
      await box.write(kCartsProducts, products);
      update();
    } else {
      log("Oh This Product Is Already In Cart ", name: "Adding New Product In");
      showToast("This product is already in the cart! please check it");
    }

    log("When Saving Data Are :${box.read(kCartsProducts)}");
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
          Get.isDarkMode ? AppColor.kThirdDarkColor : Colors.grey.shade300,
      textColor:
          Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
      fontSize: 16.0,
    );
  }

  /// ############################## MAIN Search Customers With Credits ################################### ///

  /// ############################## MAIN ################################### ///

  @override
  void onInit() {
    super.onInit();
    getcartsProducts();
    // loadPaymentMethods();
  }

  @override
  void dispose() {
    amoutDiscount.dispose();
    percentageDiscount.dispose();

    paymentMethodAsCashController.dispose();
    super.dispose();
  }
}
