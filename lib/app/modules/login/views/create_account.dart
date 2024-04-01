import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/widegts.dart';
import '../../../../constants/constants.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (create) {
          return Form(
            key: create.createformKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.075),
                        Image.asset(
                          'assets/logo/lightLogo-01.png',
                          width: 350,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Text(
                          "Hello there!",
                          style: TextStyle(
                            fontSize: 18,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Let's get started on creating your account.",
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        Stepper(
                          controlsBuilder: (context, details) {
                            return SizedBox();
                          },
                          currentStep: create.currentStepIndex,
                          physics: NeverScrollableScrollPhysics(),
                          onStepCancel: () => create.onStepCancel(),
                          onStepContinue: () => create.onStepContinue(context),
                          onStepTapped: (index) => create.onStepTapped(index),
                          steps: create.steps(create),
                          connectorThickness: 2,
                          connectorColor: MaterialStateColor.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.blue;
                              } else {
                                return AppColor.kJtechPrimaryColor;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        SignInBtn(
                          text: "Create Account",
                          onPressed: () {
                            create.createAccount(context);
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "I have already an account go to sign-In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        CreateAccount(
                          text: "Sign In",
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        SizedBox(height: 20),
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



  // Steper Stapes
  // List<Step> steps = ;