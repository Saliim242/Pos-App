import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/widegts.dart';

import '../../../../constants/constants.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
          'Change Password',
          style: GoogleFonts.metrophobic(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<LoginController>(
        builder: (newPass) {
          return Form(
            key: newPass.changePasswordformKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: LottieBuilder.asset(
                          'assets/animations/Reset Password.json',
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        "Your New Password Must Be Unique From You'r Previouly Password.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.070),
                      CustomTextFeilds(
                        hintText: "Enter New Password",
                        showPassowrd: newPass.isChangedPassword,
                        controller: newPass.newPasswordController,
                        iconData: IconlyBroken.password,
                        onTap: () => newPass.changeShowAndHidePassword(),
                        ispassword: true,
                        passIcon: newPass.isChangedPassword
                            ? IconlyBroken.hide
                            : IconlyBroken.show,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      CustomTextFeilds(
                        hintText: "Enter Confirm New Password",
                        showPassowrd: newPass.isChangedPassword,
                        controller: newPass.confirmNewPasswordController,
                        iconData: IconlyBroken.password,
                        ispassword: true,
                        onTap: () => newPass.changeShowAndHidePassword(),
                        passIcon: newPass.isChangedPassword
                            ? IconlyBroken.hide
                            : IconlyBroken.show,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.070),
                      SignInBtn(
                        text: "Change Password",
                        onPressed: () {
                          newPass.changePassowrdToNew(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
