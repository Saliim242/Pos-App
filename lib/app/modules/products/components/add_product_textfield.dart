import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';

import '../../../../constants/constants.dart';

class AddProductsTextFeilds extends StatelessWidget {
  final String hintText;
  final IconData? iconData;
  final IconData? passIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;

  final TextEditingController controller;
  final bool isEmail;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AddProductsTextFeilds({
    super.key,
    required this.hintText,
    this.iconData,
    this.passIcon,
    this.onTap,
    required this.controller,
    this.isEmail = false,
    this.keyboardType,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomersController>(builder: (e) {
      return Container(
        child: TextFormField(
          scrollPadding: EdgeInsets.all(0),
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscuringCharacter: '*',
          validator: (value) {
            if (value!.isEmpty || value == '') {
              return '';
            } else if (isEmail ? !e.isEmailValid(value) : false) {
              return 'Oops! Your email format seems off. Please enter a valid email address.';
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
            // enabledBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(color: Colors.blueGrey, width: 1),
            // ),
            focusedBorder: const OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColor.kJtechPrimaryColor,
                width: 1,
              ),
            ),
            // errorBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(
            //     color: AppColor.kJtechSecondColor,
            //     width: 1,
            //   ),
            // ),
            // focusedErrorBorder: const OutlineInputBorder().copyWith(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide: BorderSide(
            //       color: AppColor.kJtechSecondColor.withOpacity(0.3), width: 2),
            // ),
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
        ),
      );
    });
  }
}
