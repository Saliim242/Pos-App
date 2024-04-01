import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ReusableDrawerMenu extends StatelessWidget {
  const ReusableDrawerMenu({
    super.key,
    this.child,
    this.icon,
    required this.text,
    this.onTap,
  });
  final void Function()? onTap;
  final Widget? child;
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: child!,
          type: PageTransitionType.rightToLeft,
        ),
      ),
      leading: Icon(
        icon,
        color: Get.isDarkMode
            ? const Color(0xffe5e5e5)
            : const Color(0xffd6d6d6), //Color(0xff3E3C59),
        size: 22,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "Metrophobic",
          fontSize: 14,
          color: Get.isDarkMode
              ? const Color(0xffe5e5e5)
              : const Color(0xffd6d6d6),
        ),
      ),
    );
  }
}

//AboutUsScreen()  IconlyBroken.location,   "Welcome",