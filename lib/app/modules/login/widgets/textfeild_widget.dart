import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';

import '../../../../constants/constants.dart';

class CustomTextFeilds extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final IconData? passIcon;
  final void Function()? onTap;
  final bool showPassowrd;
  final TextEditingController controller;
  final bool isEmail;
  final bool ispassword;
  final TextInputType? keyboardType;

  const CustomTextFeilds({
    super.key,
    required this.hintText,
    this.iconData,
    this.passIcon,
    this.onTap,
    required this.showPassowrd,
    required this.controller,
    this.isEmail = false,
    this.ispassword = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (e) {
      return Container(
        child: TextFormField(
          scrollPadding: EdgeInsets.all(0),
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          obscuringCharacter: '*',
          validator: (value) {
            if (value!.isEmpty || value == '') {
              return '';
            } else if (isEmail ? !e.isEmailValid(value) : false) {
              return 'Oops! Your email format seems off. Please enter a valid email address.';
            } else if (ispassword ? value.length < 8 : false) {
              return "Whoops! Password needs at least 8 characters. Add a bit more length.";
              //ispassword ? !e.isPasswordValid(value) : false
            }
            return null;
          },
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(18),
            border: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Get.isDarkMode ? Colors.grey.shade200 : Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blueGrey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.kJtechPrimaryColor,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.kJtechSecondColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: AppColor.kJtechSecondColor.withOpacity(0.3), width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode
                  ? Colors.grey.shade300.withOpacity(0.6)
                  : AppColor.kJtechPrimaryColor.withOpacity(0.6),
            ),
            prefixIcon: Icon(
              iconData,
              size: 24,
              color: Get.isDarkMode
                  ? AppColor.kbgColor.withOpacity(0.6)
                  : AppColor.kJtechPrimaryColor,
            ),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                passIcon,
                size: 24,
                color: Get.isDarkMode
                    ? AppColor.kbgColor.withOpacity(0.6)
                    : AppColor.kJtechPrimaryColor,
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
          obscureText: showPassowrd,
        ),
      );
    });
  }
}
