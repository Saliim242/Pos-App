import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_manangement_app/app/modules/login/views/login_view.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import 'package:pos_manangement_app/constants/constants.dart';

class successfullyChanged extends StatefulWidget {
  const successfullyChanged({super.key});

  @override
  State<successfullyChanged> createState() => _successfullyChangedState();
}

class _successfullyChangedState extends State<successfullyChanged> {
  //final LoginController controller = Get.put(LoginController());
  // @override
  // void dispose() {
  //   Get.delete<LoginController>();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                SizedBox(
                  height: 250,
                  width: 250,
                  child: LottieBuilder.asset(
                    'assets/animations/success.json',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  "Password Changed Succefully! 🚀",
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  "You've successfully changed your password. Thanks for keeping your account secure.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                    // fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SignInBtn(
                  text: "Go Sign In Again",
                  onPressed: () => Get.to(
                    () => LoginView(),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
