import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/themes/theme_services.dart';

import '../../../../constants/constants.dart';
import '../controllers/home_controller.dart';

AppBar CustomAppBarWidget(
    HomeController cont, AnimationController rotationController) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: Get.isDarkMode ? 0.5 : 0.5,
    backgroundColor: //Theme.of(Get.context!).primaryColor,
        Get.isDarkMode
            ? Theme.of(Get.context!).cardColor
            : Theme.of(Get.context!).scaffoldBackgroundColor,
    centerTitle: true,
    title: Marquee(
      child: Text(
        'JTech Point of Sale  Management ',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
      ),
    ),
    leading: RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
      child: IconButton(
        icon: cont.zoomDrawerController.open != null
            ? cont.isDrawerOpen
                ? Icon(
                    IconlyBroken.close_square,
                    size: 35,
                    //color: Get.theme.hoverColor,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  )
                : Icon(
                    IconlyBroken.category,
                    //IconlyBroken.more_square,
                    //color: Get.theme.hoverColor,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  )
            : Icon(
                IconlyBroken.category,
                //color: Get.theme.hoverColor,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
        tooltip: 'Menu',
        onPressed: () => cont.toggleDrawer(
          rotationController: rotationController,
        ),
      ),
    ),
    actions: [
      // IconButton(
      //   onPressed: () {
      //     Get.to(() => CustomersView());
      //   },
      //   icon: Icon(IconlyBroken.add_user),
      // ),
      IconButton(
        onPressed: () {
          ServicesThemes().changeThemeDynamically();
        },
        icon: Icon(Iconsax.moon),
      )
    ],
  );
}
