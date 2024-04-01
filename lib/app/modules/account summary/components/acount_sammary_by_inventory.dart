import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos_manangement_app/constants/constants.dart';

import '../../../../constants/custom_line_clip_path.dart';
import 'custom_sales_categoreis_and_products.dart';

class AcountSummaryByInventory extends StatelessWidget {
  const AcountSummaryByInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipper: CouponClipper(
            direction: Directionality.of(context),
            curvePosition: MediaQuery.of(context).size.height * 0.07,
            curveRadius: 40,
            // borderRadius: 8,
            // clockwise: true,
            curveAxis: Axis.horizontal,
          ),
          child: Container(
            //height: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Colors.white, // Set Container background color to white
              boxShadow: [
                Get.isDarkMode
                    ? BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.shade300, // Set shadow color
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Get.isDarkMode
                    ? AppColor.kSecondDarkColor
                    : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Whole Inventory Information!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "${0} Products",
                      style: TextStyle(
                          fontSize: 13,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor.withOpacity(0.65)
                              : AppColor.kJtechPrimaryColor
                                  .withOpacity(0.65) //Color(0xffA8AEB8),
                          ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${0} Categories",
                      style: TextStyle(
                        fontSize: 13,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor.withOpacity(0.65)
                            : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                MySeparator(
                  color:
                      Get.isDarkMode ? AppColor.kSecondDarkColor : Colors.grey,
                ),
                SizedBox(height: 16),

                // Inventory Total Money and Sales
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Inventory Cost",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${moneyFormater(3755).compactSymbolOnLeft}",
                          style: TextStyle(
                            fontSize: 17,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Inventory Sales",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("${moneyFormater(98752).compactSymbolOnLeft}",
                            style: TextStyle(
                              fontSize: 17,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kTexMoneyColor,
                            )),
                      ],
                    )
                  ],
                ),

                SizedBox(height: 16),
                MySeparator(
                  color:
                      Get.isDarkMode ? AppColor.kSecondDarkColor : Colors.grey,
                ),
                SizedBox(height: 16),
                InventoryInformationWidget(
                  bgColor: Color(0XFFe0faef),
                  icon: IconlyBroken.shield_done,
                  items: 340,
                  title: "Availble In Stock",
                  styleColor: Color(0xff16c57D),
                ),
                SizedBox(height: 8),
                InventoryInformationWidget(
                  bgColor: Color(0XFFFEF5E4),
                  icon: IconlyBroken.graph,
                  items: 10,
                  title: "Low Stock Alert",
                  styleColor: Color(0xffEAA029),
                  border: Border.all(
                      color: Color(0xffEAA029).withOpacity(0.35), width: 1),
                ),
                SizedBox(height: 8),
                InventoryInformationWidget(
                  bgColor: Color(0XFFFBEBEC),
                  icon: Icons.hourglass_empty,
                  items: 5,
                  title: "Out of Stock",
                  styleColor: Color(0xffcb374b),
                  border: Border.all(
                      color: Color(0xffcb374b).withOpacity(0.35), width: 1),
                ),
                SizedBox(height: 8),
                InventoryInformationWidget(
                  bgColor: Color(0XFFF1F1F1),
                  icon: Iconsax.truck_fast,
                  items: 5,
                  title: "No Inventory Tracking",
                  styleColor: Color(0xff8b8b8b),
                  border: Border.all(
                      color: Color(0xff8b8b8b).withOpacity(0.35), width: 1),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        // Text(
        //   "Top Selling Categories",
        //   style: TextStyle(
        //     fontSize: 15,
        //     color: Get.isDarkMode
        //         ? AppColor.kbgColor
        //         : AppColor.kJtechPrimaryColor,
        //   ),
        // ),
        ClipPath(
          clipper: CouponClipper(
            direction: Directionality.of(context),
            curvePosition: MediaQuery.of(context).size.height * 0.07,
            curveRadius: 40,
            // borderRadius: 8,
            // clockwise: true,
            curveAxis: Axis.horizontal,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? Theme.of(context).cardColor
                  : Colors.white, // Set Container background color to white
              boxShadow: [
                Get.isDarkMode
                    ? BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.shade300, // Set shadow color
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Get.isDarkMode
                    ? AppColor.kSecondDarkColor
                    : Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Selling Categories",
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                MySeparator(
                  color:
                      Get.isDarkMode ? AppColor.kSecondDarkColor : Colors.grey,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                AccountTopSellingByCategoriesAndProducts(
                  categoriesName: "Electronics",
                  howManyItems: 4,
                  sellingPrice: 567,
                ),
                //  SizedBox(height: 16),
                AccountTopSellingByCategoriesAndProducts(
                  categoriesName: "Sports",
                  howManyItems: 4,
                  sellingPrice: 2505,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class InventoryInformationWidget extends StatelessWidget {
  const InventoryInformationWidget({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.items,
    required this.styleColor,
    this.border,
  });

  final Color bgColor;
  final IconData icon;
  final String title;
  final Color styleColor;
  final int items;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: styleColor,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: styleColor,

                  // Get.isDarkMode
                  //     ? AppColor.kbgColor
                  //     : AppColor.kJtechPrimaryColor,
                ),
              )
            ],
          ),
          Text(
            "$items items",
            style: TextStyle(fontSize: 15, color: styleColor

                // Get.isDarkMode
                //     ? AppColor.kbgColor
                //     : AppColor.kJtechPrimaryColor,
                ),
          )
        ],
      ),
    );
  }
}
