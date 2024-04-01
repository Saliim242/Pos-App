import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/widegts.dart';
import 'package:pos_manangement_app/constants/constants.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Theme.of(Get.context!).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            IconlyBroken.arrow_left_square,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Forget your password',
          style: GoogleFonts.metrophobic(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<LoginController>(builder: (forget) {
        return Form(
          key: forget.verificationFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Lottie.asset(
                        'assets/animations/Reset Password.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Text(
                      "Don't worry! it happens Enter the Email you used to create your account so we can send you verification code.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    CustomTextFeilds(
                      hintText: "Enter your E-mail",
                      showPassowrd: false,
                      controller: forget.forgetPasswordController,
                      iconData: IconlyBroken.message,
                      isEmail: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    SignInBtn(
                      text: "Send Verification Code",
                      onPressed: () {
                        forget.sendVerificationCode(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
