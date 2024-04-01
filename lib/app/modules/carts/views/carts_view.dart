import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/views/add_discount_screen.dart';
import 'package:pos_manangement_app/app/modules/carts/views/cash_out_screen.dart';
import 'package:pos_manangement_app/app/modules/components/custom_error_screens.dart';
import '../../../../constants/constants.dart';
import '../components/cart_card_design.dart';
import '../controllers/carts_controller.dart';
import 'package:badges/badges.dart' as badges;

class CartsView extends GetView<CartsController> {
  const CartsView({Key? key}) : super(key: key);
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
            'Your Shopping Cart',
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
        actions: [
          GetBuilder<CartsController>(builder: (crt) {
            return badges.Badge(
              showBadge: crt.cartLength == 0 ? false : true,
              badgeContent: Text(
                "${crt.cartLength}",
                style: TextStyle(color: AppColor.kbgColor),
              ),
              position: badges.BadgePosition.topEnd(end: 2),
              badgeStyle: badges.BadgeStyle(
                badgeColor: AppColor.kJtechSecondColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  IconlyBroken.bag,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                  size: 30,
                ),
              ),
            );
          })
        ],
      ),
      body: GetBuilder<CartsController>(
        builder: (cart) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                //SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Expanded(
                  flex: 2,
                  child: GetBuilder<CartsController>(
                    builder: (cr) {
                      if (cr.cartsProducts.isEmpty) {
                        return CustomEmplyScreen(
                          img: 'assets/animations/empty.json',
                          content:
                              'OPPS! Your cart is empty! Explore and add your favorite items for a delightful shopping experience.',
                        );
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 375),
                          child: AnimationLimiter(
                            child: ListView.builder(
                              //physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.cartsProducts.length,
                              itemBuilder: (context, index) =>
                                  AnimationConfiguration.staggeredList(
                                duration: const Duration(milliseconds: 375),
                                position: index,
                                child: ScaleAnimation(
                                  delay: const Duration(milliseconds: 200),
                                  // horizontalOffset: 50,
                                  // verticalOffset: 50.0,
                                  child: SlideAnimation(
                                    delay: const Duration(milliseconds: 300),
                                    child: FocusedMenuHolder(
                                      menuWidth:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                      openWithTap: true,
                                      animateMenuItems: true,
                                      blurBackgroundColor: Colors.black45,
                                      blurSize: 1,
                                      menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(
                                          backgroundColor:
                                              AppColor.kJtechSecondColor,
                                          title: const Text(
                                            "Remove it",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          trailingIcon: const Icon(
                                              IconlyBroken.delete,
                                              color: Colors.white),
                                          onPressed: () {
                                            cart.removeCartItems(
                                              cart.cartsProducts[index],
                                            );
                                          },
                                        ),
                                      ],
                                      onPressed: () {},
                                      child: CartsCardView(
                                        pro: cart.cartsProducts[index],
                                        increment: () => cart.incrementQty(
                                          cart.cartsProducts[index],
                                          index,
                                        ),
                                        decrement: () => cart.decrementQty(
                                          cart.cartsProducts[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GetBuilder<CartsController>(
                    builder: (crt) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Theme.of(Get.context!).cardColor
                              : Color(0xfffffffff),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechPrimaryColor,
                                  ),
                                ),
                                Text(
                                  //crt.totalPrice
                                  "${moneyFormater(crt.box2.hasData(crt.calculatingPrice) ? crt.box2.read(crt.calculatingPrice) : 0).compactSymbolOnLeft}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.kTexMoneyColor,
                                  ),
                                )
                              ],
                            ),
                            // Discount Card Text
                            SizedBox(height: 4),

                            Visibility(
                              visible: crt.showDiscount,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? AppColor.kbgColor
                                          : AppColor.kJtechPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "- ${crt.isAmoutOrPersentage ? moneyFormater(double.parse(crt.amoutDiscount.text)).compactSymbolOnRight : moneyFormater(double.parse(crt.percentageDiscount.text)).compactSymbolOnRight}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.kJtechSecondColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //SizedBox(height: 10),

                            SizedBox(height: 8),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 2,
                              color: Get.isDarkMode
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Colors.grey.shade200,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtomCardProporties(
                                    title: "Empty cart",
                                    borderColor: AppColor.kJtechSecondColor,
                                    icon: IconlyBroken.delete,
                                    iconColor: AppColor.kJtechSecondColor,
                                    onTap: () {
                                      log("Empty Cart");

                                      crt.removeAllCartItems();
                                    },
                                    textColor: Get.isDarkMode
                                        ? AppColor.kbgColor.withOpacity(0.8)
                                        : AppColor.kJtechPrimaryColor,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ButtomCardProporties(
                                    title: "Add Discount",
                                    borderColor: Colors.lightBlue,
                                    icon: IconlyBroken.discount,
                                    iconColor: Colors.lightBlue,
                                    onTap: () {
                                      log("Discount");
                                      Get.to(
                                        () => AddDiscountPage(),
                                        fullscreenDialog: true,
                                        transition: Transition.downToUp,
                                      );
                                    },
                                    textColor: Get.isDarkMode
                                        ? AppColor.kbgColor.withOpacity(0.8)
                                        : AppColor.kJtechPrimaryColor,
                                  ),
                                ),
                                // SizedBox(width: 8),
                                // Expanded(
                                //   child: ButtomCardProporties(
                                //     title: "Add Customer",
                                //     borderColor: Colors.grey,
                                //     icon: IconlyBroken.profile,
                                //     iconColor: Colors.grey,
                                //     textColor: Get.isDarkMode
                                //         ? AppColor.kbgColor.withOpacity(0.8)
                                //         : Colors.grey,
                                //     onTap: () {},
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => CashOutScreen(),
                                    fullscreenDialog: true,
                                    transition: Transition.rightToLeftWithFade,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.kJtechSecondColor,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Process CheckOut",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.kbgColor,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        //crt.totalPrice
                                        "${moneyFormater(crt.box2.hasData(crt.calculatingPrice) ? crt.box2.read(crt.calculatingPrice) : 0).compactSymbolOnLeft}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.kbgColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ButtomCardProporties extends StatelessWidget {
  const ButtomCardProporties({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.borderColor,
    this.onTap,
    required this.textColor,
  });

  final IconData icon;
  final String title;
  final Color iconColor;
  final Color borderColor;
  final Color textColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        // width: 70,
        //height: 85,
        decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(
            color: borderColor,
            width: 0.85,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 35,
            ),
            //SizedBox(height: 4),
            Text(
              "${title}",
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*


      bottomNavigationBar: GetBuilder<CartsController>(
        builder: (crt) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 65,
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
              boxShadow: [
                Get.isDarkMode
                    ? BoxShadow()
                    : BoxShadow(
                        color: AppColor.kJtechPrimaryColor.withOpacity(0.1),
                        offset: Offset(1, -1),
                        blurRadius: 2,
                      )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${crt.box2.hasData(crt.calculatingPrice) ? moneyFormater(crt.box2.read(crt.calculatingPrice)).compactSymbolOnLeft : 0}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.kJtechSecondColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.wallet_check,
                          color: AppColor.kbgColor,
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Process to CheckOut",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kbgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),




*/