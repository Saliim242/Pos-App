import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';

import '../../../../constants/constants.dart';
import '../views/forget_password.dart';

class ForgetPasswordAndRememberMe extends StatelessWidget {
  const ForgetPasswordAndRememberMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (login) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: login.rememberMe,
                onChanged: (newValue) => login.checkRememberMe(newValue!),
              ),
              Text(
                "Remember Me",
                style: TextStyle(
                  fontSize: 14,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Get.to(() => ForgetPassword());
            },
            child: Text(
              "Forget Password",
              style: TextStyle(
                fontSize: 15,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    });
  }
}
