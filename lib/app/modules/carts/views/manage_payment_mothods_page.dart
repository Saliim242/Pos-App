import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/constants/constants.dart';

import '../models/cash_model.dart';

class ManagePaymentMethodsPage extends StatelessWidget {
  const ManagePaymentMethodsPage({super.key});

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
            'Manage Your Payment Methods',
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
      body: GetBuilder<CartsController>(
        builder: (pay) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cashModelServices.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // final service = cashModelServices[index];
                        return ManagePaymentMethodCard(
                          cash: cashModelServices[index],
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColor.kJtechPrimaryColor
                              : AppColor.kJtechPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.add_circle,
                                color: AppColor.kbgColor, size: 25),
                            SizedBox(width: 12),
                            Text(
                              "Add New Payment Method",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.kbgColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ManagePaymentMethodCard extends StatelessWidget {
  ManagePaymentMethodCard({
    super.key,
    required this.cash,
  });

  final CashModelServices cash;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartsController>(builder: (cc) {
      return Container(
        //padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Get.isDarkMode ? Colors.blueGrey : Colors.grey.shade300,
          ),
          boxShadow: [
            Get.isDarkMode
                ? BoxShadow()
                : BoxShadow(
                    color: AppColor.kJtechPrimaryColor.withOpacity(0.2),
                    offset: Offset(1, 1),
                    blurRadius: 1,
                  )
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          tileColor: Colors.transparent,
          trailing: Transform.scale(
            scale: 0.8,
            alignment: Alignment.center,
            // scaleX: 0.8,
            // scaleY: 0.8,
            child: Switch(
              value: cash.isPaymentShow,
              onChanged: (bool value) {},
              // cus.updateShowCreditTextFeilds(value),
              //activeColor: AppColor.kbgColor,

              activeTrackColor: AppColor.kTexMoneyColor,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.shade200,
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? AppColor.kSecondDarkColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              '${cash.iconPath}',
              height: 40,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          title: Text(
            "${cash.title}",
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
        ),
      );
    });
  }
}



// Container(
//                           child: Row(
//                             children: [
//                               Row
//                             ],
//                           ),
//                         )