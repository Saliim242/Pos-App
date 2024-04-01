import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';

class AcountSummaryByPaymentMethodsType extends StatelessWidget {
  const AcountSummaryByPaymentMethodsType({super.key});

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
              "Sales By Payment Methods",
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: salesByProducts.length,
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                return PaymentMethodTypesInAccountSammery(
                  paymentType: salesByProducts[index][0],
                  money: salesByProducts[index][1],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTypesInAccountSammery extends StatelessWidget {
  const PaymentMethodTypesInAccountSammery({
    super.key,
    required this.paymentType,
    required this.money,
  });

  final String paymentType;
  final int money;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text("${paymentType}"),
      trailing: Text(
        "${moneyFormater(money.toDouble()).compactSymbolOnLeft}",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff16c57D),
          fontWeight: FontWeight.w600,
          // Get.isDarkMode
          //     ? AppColor.kbgColor
          //     : AppColor.kJtechPrimaryColor,
        ),
      ),
    );
  }
}

List salesByProducts = [
  ["Cash", 300],
  ["EVC Plus", 9878],
  ["E-Wallet", 8595],
  ["Credit", 250],
  ["Bank", 85],
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