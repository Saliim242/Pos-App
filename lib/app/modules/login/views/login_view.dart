import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:pos_manangement_app/app/modules/login/views/create_account.dart';
import 'package:pos_manangement_app/app/themes/theme_services.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import '../controllers/login_controller.dart';
import '../widgets/widegts.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (login) {
          return Form(
            key: login.signInformKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075),
                        IconButton(
                          onPressed: () {
                            ServicesThemes().changeThemeDynamically();
                          },
                          icon: Icon(Icons.dark_mode_rounded),
                        ),
                        Image.asset("assets/logo/lightLogo-01.png"),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Text(
                          "Welcome Back !",
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Discover limitless choices and unmatched Convenience.",
                          style: TextStyle(
                            fontSize: 14.5,
                            color: isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        CustomTextFeilds(
                          hintText: "Enter Your E-mail",
                          iconData: IconlyBroken.message,
                          showPassowrd: false,
                          controller: login.emailController,
                          isEmail: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        CustomTextFeilds(
                          controller: login.passwordController,
                          hintText: "Enter Your Password",
                          iconData: IconlyBroken.password,
                          passIcon: login.ispassword
                              ? IconlyBroken.hide
                              : IconlyBroken.show,
                          onTap: () {
                            login.showAndHideSignInPassword();
                          },
                          showPassowrd: login.ispassword,
                          ispassword: true,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 5),
                        ForgetPasswordAndRememberMe(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075),
                        SignInBtn(
                          text: "Sign In",
                          onPressed: () {
                            Logger().i(
                                "${login.emailController.text} and ${login.passwordController.text}");

                            login.signIn();

                            //ScaffoldMessenger.of(context).showSnackBar(snack);
                          },
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "I don't have already an account create now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        CreateAccount(
                          text: "Create an Account",
                          onPressed: () => Get.to(
                            () => CreateNewAccount(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
