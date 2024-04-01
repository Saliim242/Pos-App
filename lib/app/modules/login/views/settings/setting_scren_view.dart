import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';

import '../../../../../constants/constants.dart';

class SettingScreenView extends StatelessWidget {
  const SettingScreenView({super.key});

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
            'Settings',
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Icon(
                    Icons.person_2,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bussiness Name"),
                    Text("figma7050@gmail.com"),
                  ],
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            // Settings

            ReusableSettingCard(
              title: "Business Information",
              leadingIconData: Iconsax.buliding,
              trainIconData: IconlyBroken.arrow_right_2,
              onTap: () {},
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
              color2: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            ReusableSettingCard(
              title: "Change Currency",
              leadingIconData: Icons.currency_exchange,
              trainIconData: IconlyBroken.arrow_right_2,
              onTap: () {},
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
              color2: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),

            // ReusableSettingCard(
            //   title: "VAT Rate",
            //   leadingIconData: Icons.percent_outlined,
            //   trainIconData: IconlyBroken.arrow_right_2,
            //   onTap: () {},
            //   color: Get.isDarkMode
            //       ? AppColor.kbgColor
            //       : AppColor.kJtechPrimaryColor,
            //   color2: Get.isDarkMode
            //       ? AppColor.kbgColor
            //       : AppColor.kJtechPrimaryColor,
            // ),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            ReusableSettingCard(
              title: "Delete  Account",
              leadingIconData: IconlyBroken.delete,
              trainIconData: IconlyBroken.arrow_right_2,
              onTap: () {},
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechSecondColor,
              color2: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableSettingCard extends StatelessWidget {
  const ReusableSettingCard({
    super.key,
    required this.title,
    required this.leadingIconData,
    required this.trainIconData,
    this.onTap,
    required this.color,
    required this.color2,
  });

  final String title;
  final IconData leadingIconData;
  final IconData trainIconData;
  final void Function()? onTap;
  final Color color;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Hello Boss I'm Ready");
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  leadingIconData,
                  color: color,
                ),
                SizedBox(width: 8),
                Text(
                  "${title}",
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  ),
                ),
              ],
            ),
            Icon(
              trainIconData,
              color: color2,
            ),
          ],
        ),
      ),
    );
  }
}
