import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/constants/constants.dart';

import '../../../../constants/custom_line_clip_path.dart';
import 'custom_sales_categoreis_and_products.dart';

class AcountSummaryBySalesProduct extends StatelessWidget {
  const AcountSummaryBySalesProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CouponClipper(
        direction: Directionality.of(context),
        curvePosition: MediaQuery.of(context).size.height * 0.056,
        curveRadius: 40,
        // borderRadius: 8,
        // clockwise: true,
        curveAxis: Axis.horizontal,
      ),
      child: Container(
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
                    offset: Offset(35, 3), // changes position of shadow
                  ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Sales By Products",
              style: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            MySeparator(
              color: Get.isDarkMode ? AppColor.kSecondDarkColor : Colors.grey,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: salesByProducts.length,
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                return AccountTopSellingByCategoriesAndProducts(
                  categoriesName:
                      "${index + 1}--- ${salesByProducts[index][0]}",
                  howManyItems: salesByProducts[index][1],
                  sellingPrice: salesByProducts[index][2],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox();
                //MySeparator();
              },
            )
          ],
        ),
      ),
    );
  }
}

List salesByProducts = [
  ["Iphone 15 Pro Max", 3, 300],
  ["Hp Laptop", 7, 9878],
  ["MackBook Pro", 2, 8595],
  ["Air Pods", 15, 250],
  ["Keyboards", 4, 85],
  ["Apple watches", 3, 600],
  ["Acer", 1, 120],
  ["Desktop ", 12, 89639],
  ["Chairs", 3, 1200],
  ["Samsung Telephone", 100, 189666],
];


//  AccountTopSellingByCategoriesAndProducts(
//               categoriesName: "Iphone 15 Pro Max",
//               howManyItems: 3,
//               sellingPrice: 300,
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//             AccountTopSellingByCategoriesAndProducts(
//               categoriesName: "Iphone 15 Pro Max",
//               howManyItems: 3,
//               sellingPrice: 300,
//             )