import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import 'package:pos_manangement_app/constants/constants.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
          'OTP',
          style: GoogleFonts.metrophobic(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<LoginController>(builder: (otp) {
        return Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Text(
                      "Enter the verification code we just send you on your email address.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Pinput(
                      length: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'OTP IS REQUIRED';
                        }
                        return null;
                      },
                      controller: otp.pinputController,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      onSubmitted: (value) => otp.onSave(value),
                      defaultPinTheme: PinTheme(
                        width: 64,
                        height: 68,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45.withOpacity(0.3),
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                              blurRadius: 3,
                            )
                          ],
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 64,
                        height: 68,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor.withOpacity(0.7)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    SignInBtn(
                      text: "Verify Code",
                      onPressed: () {
                        otp.verifyCode(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
