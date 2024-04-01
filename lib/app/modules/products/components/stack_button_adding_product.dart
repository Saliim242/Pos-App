import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../constants/constants.dart';
import '../../carts/controllers/carts_controller.dart';
import '../../carts/views/carts_view.dart';
import 'add_new_products.dart';

class ProductStackAddButtom extends StatelessWidget {
  const ProductStackAddButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<CartsController>();
    return Positioned(
      bottom: 12,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => AddNewProducts(),
                fullscreenDialog: true,
                transition: Transition.downToUp,
              );
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? AppColor.kSecondDarkColor
                    : AppColor.kJtechSecondColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Iconsax.add_circle,
                size: 30,
                color: AppColor.kbgColor,
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: ctrl.cartLength != 0
                ? () {
                    Get.to(
                      () => CartsView(),
                      fullscreenDialog: true,
                      transition: Transition.downToUp,
                    );
                  }
                : () {},
            child: GetBuilder<CartsController>(builder: (crt) {
              return Container(
                padding: EdgeInsets.all(15),
                // width: 60,
                //height: 60,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? AppColor.kSecondDarkColor
                      : AppColor.kJtechPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    badges.Badge(
                      showBadge: crt.cartLength == 0 ? false : true,
                      badgeContent: Text(
                        "${crt.cartLength}",
                        style: TextStyle(
                          color: AppColor.kbgColor,
                        ),
                      ),
                      position: badges.BadgePosition.topEnd(top: -10, end: -3),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: AppColor.kJtechSecondColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: Icon(
                          IconlyBroken.buy,
                          color: AppColor.kbgColor,
                          size: 25,
                        ),
                      ),
                    ),
                    // Icon(
                    //   IconlyBroken.buy,
                    //   color: AppColor.kbgColor,
                    //   size: 26,
                    // ),
                    SizedBox(width: 10),
                    Text(
                      "Items",
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColor.kbgColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "${moneyFormater(crt.totalPrice).compactSymbolOnLeft}",
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColor.kbgColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? AppColor.kSecondDarkColor
                  : AppColor.kJtechSecondColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              IconlyBroken.scan,
              color: AppColor.kbgColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
