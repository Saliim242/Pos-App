import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pos_manangement_app/constants/constants.dart';

class FocusedMenuHolders extends StatelessWidget {
  const FocusedMenuHolders({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.50,
      openWithTap: true,
      animateMenuItems: true,
      blurBackgroundColor: Colors.black45,
      blurSize: 1,
      menuBoxDecoration: BoxDecoration(
          // color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          // borderRadius: BorderRadius.circular(10),

          //color: Colors.amber,
          ),
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          title: Text(
            "Open",
            style: TextStyle(
              fontSize: 15,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
          trailingIcon: Icon(
            Icons.open_in_new,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
          onPressed: () {},
          backgroundColor:
              Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
        ),
        FocusedMenuItem(
            title: Text(
              "Share",
              style: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
            trailingIcon: Icon(
              Icons.share,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
            backgroundColor:
                Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
            onPressed: () {}),
        FocusedMenuItem(
          title: Text(
            "Edit",
            style: TextStyle(
              fontSize: 15,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
          backgroundColor:
              Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          trailingIcon: Icon(
            IconlyBroken.edit_square,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
          onPressed: () {},
        ),
        FocusedMenuItem(
            backgroundColor: AppColor.kJtechSecondColor,
            title: const Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            trailingIcon: const Icon(IconlyBroken.delete, color: Colors.white),
            onPressed: () {}),
      ],
      onPressed: () {},
      child: child,
    );
  }
}
