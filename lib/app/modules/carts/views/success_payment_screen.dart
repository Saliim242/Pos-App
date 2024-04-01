import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';

import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';

class SuccessfullyPaymentScreen extends StatelessWidget {
  const SuccessfullyPaymentScreen(
      {super.key, this.paymentMethod, this.charge, this.isCreditShow});

  final String? paymentMethod;
  final double? charge;
  final bool? isCreditShow;

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
            'Transaction Receipe',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: CouponClipper(
                direction: Directionality.of(context),
                curvePosition: MediaQuery.of(context).size.height * 0.25,
                curveRadius: 40,
                curveAxis: Axis.horizontal,
              ),

              //ZigZagClipper(),
              child: ClipPath(
                clipper: ZigZagClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Theme.of(context).cardColor
                        : Colors
                            .white, // Set Container background color to white
                    boxShadow: [
                      Get.isDarkMode
                          ? BoxShadow()
                          : BoxShadow(
                              color: Colors.grey.shade300, // Set shadow color
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset:
                                  Offset(35, 3), // changes position of shadow
                            ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LottieBuilder.asset(
                        'assets/animations/success.json',
                        fit: BoxFit.cover,
                        animate: true,
                        height: 150,

                        ///width: 200,
                      ),
                      MySeparator(
                          color: Get.isDarkMode
                              ? AppColor.kSecondDarkColor
                              : Colors.grey),
                      Text(
                        "Sucessfully Transaction !",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade200,
                          border: Border.all(
                            color: AppColor.kJtechPrimaryColor.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: GetBuilder<CartsController>(builder: (success) {
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Method Type : ${paymentMethod}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              isCreditShow!
                                  ? SizedBox()
                                  : Text(
                                      "Charge : ${moneyFormater(success.chargeAmount).compactSymbolOnLeft}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Get.isDarkMode
                                            ? AppColor.kbgColor
                                            : AppColor.kJtechPrimaryColor,
                                      ),
                                    ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            SignInBtn(
                text: "Back To POS",
                onPressed: () {
                  // Get.offAll(
                  //   () => HomeView(),
                  // );
                }),
          ],
        ),
      ),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    double x = 10;
    double y = size.height;
    double increment = size.width / 20;

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height * .95 : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}
