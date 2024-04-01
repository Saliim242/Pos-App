import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:pos_manangement_app/app/modules/home/views/home_view.dart';
import 'package:pos_manangement_app/app/modules/login/views/otp_screen.dart';

import '../../../../constants/display_message_errors.dart';

import '../views/new_password_screen.dart';
import '../views/success_pass.dart';
import '../widgets/textfeild_widget.dart';

class LoginController extends GetxController {
  String email = "salim@gmail.com";
  int pass = 12345678;
  final box = GetStorage();

  int currentStepIndex = 0;
  final signInformKey = GlobalKey<FormState>();
  final createformKey = GlobalKey<FormState>();
  final changePasswordformKey = GlobalKey<FormState>();
  final verificationFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool ispassword = true;
  bool isCreatepassword = true;
  bool isChangedPassword = true;
  bool rememberMe = false;

  // SignIn Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Forget password and Pin Put Contrillers
  final TextEditingController forgetPasswordController =
      TextEditingController();
  final TextEditingController pinputController = TextEditingController();

  // New Password Cotroller
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  // Registration New Business
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerContentNumberController =
      TextEditingController();
  final TextEditingController ownerEmailController = TextEditingController();
  final TextEditingController BusinessNameController = TextEditingController();
  final TextEditingController BusinessTypeController = TextEditingController();
  final TextEditingController BusinessAddressController =
      TextEditingController();
  final TextEditingController ownerPasswordController = TextEditingController();
  final TextEditingController ownerPasswordConfirmController =
      TextEditingController();

  // OnStepCancel Function
  void onStepCancel() {
    if (currentStepIndex > 0) {
      currentStepIndex--;
      update();
    }
  }

  // onStepContinue Fun
  void onStepContinue(BuildContext context) {
    final isLastStep = currentStepIndex == steps(LoginController()).length - 1;
    if (isLastStep) {
    } else {
      currentStepIndex++;
      update();
    }
  }

  // OnStepTapted
  void onStepTapped(int index) {
    currentStepIndex = index;
    update();
  }

  // validatoir  Sign In
  void signIn() {
    if (signInformKey.currentState!.validate()) {
      Get.to(() => HomeView());

      // Get.off(() => HomeView());

      // emailController.clear();
      // passwordController.clear();
    } else {
      showSnackBars(
        context: Get.context!,
        contentType: ContentType.failure,
        title: "Hold on!",
        message:
            "It seems you're in a hurry. Don't forget to fill in both the username and password fields to join the fun.",
      );
    }
  }

  // SignUp or Create An Acccount
  void createAccount(BuildContext context) {
    if (createformKey.currentState!.validate()) {
      if (ownerPasswordController.text != ownerPasswordConfirmController.text) {
        showSnackBars(
          context: context,
          contentType: ContentType.failure,
          title: "Mismatched passwords!",
          message:
              "It looks like the passwords entered don't match Double-check and retry.",
        );

        ownerNameController.clear();
        ownerEmailController.clear();
        ownerContentNumberController.clear();
        ownerPasswordController.clear();
        ownerPasswordConfirmController.clear();
        BusinessNameController.clear();
        BusinessAddressController.clear();
        BusinessTypeController.clear();
      } else {
        showSnackBars(
          context: context,
          contentType: ContentType.success,
          title: "Well done, superstar! ⭐",
          message:
              "You did it! Your account is successfully created. Let the adventure begin!.",
        );
      }
    } else {
      showSnackBars(
        context: context,
        contentType: ContentType.failure,
        title: "Hold on!",
        message:
            "It seems you're in a hurry. Don't forget to fill in all fields to join the fun.",
      );
    }
  }

  // Verification Code Send
  void sendVerificationCode(BuildContext context) {
    if (verificationFormKey.currentState!.validate()) {
      // showSnackBars(
      //   context: context,
      //   title: "Oh Yeah",
      //   message:
      //       "Your E-mail Address is ghh : ${forgetPasswordController.text}!",
      //   contentType: ContentType.success,
      // );

      Get.to(() => OTPScreen());

      forgetPasswordController.clear();
    } else {
      showSnackBars(
          context: context,
          title: "Whoops!",
          message:
              "Please Provide E-mail Address to send you verification code.",
          contentType: ContentType.failure);
    }
  }

  // Verify Code Funtion
  void verifyCode(BuildContext context) {
    if (pinputController.text.isNotEmpty || pinputController.text != '') {
      print(pinputController.text);
      Get.to(() => NewPasswordScreen());

      pinputController.clear();
    } else {
      showSnackBars(
        context: context,
        title: "Whoops!",
        message:
            "It seems you forgot to enter the verification code. Please fill in the code field.",
        contentType: ContentType.failure,
      );
    }
  }

  // Make New Password User Funtion
  void changePassowrdToNew(BuildContext context) {
    if (changePasswordformKey.currentState!.validate()) {
      if (newPasswordController.text == confirmNewPasswordController.text) {
        showSnackBars(
          context: context,
          contentType: ContentType.success,
          title: "Password Changed Succefully! 🚀",
          message:
              "You've successfully changed your password. Thanks for keeping your account secure.",
        );
        Get.to(() => successfullyChanged());

        newPasswordController.clear();
        confirmNewPasswordController.clear();
      } else {
        showSnackBars(
          context: context,
          contentType: ContentType.failure,
          title: "Mismatched passwords!",
          message:
              "It looks like the passwords entered don't match Double-check and retry.",
        );
      }
    } else {
      showSnackBars(
        context: context,
        title: "Whoops!",
        message: "message",
        contentType: ContentType.failure,
      );
    }
  }

  // Show and Hide Password Funtion
  void showAndHideSignInPassword() {
    ispassword = !ispassword;
    update();
    Logger().i(
      "The Value of IsPassword is : ${ispassword}",
      time: DateTime.timestamp(),
    );
  }

  // Show and Hide Password Create
  void createshowAndHidePassword() {
    isCreatepassword = !isCreatepassword;
    update();
    Logger().i(
      "The Value of IsPassword is : ${isCreatepassword}",
      time: DateTime.timestamp(),
    );
  }

  void changeShowAndHidePassword() {
    isChangedPassword = !isChangedPassword;
    update();
  }

  // Check Remember Me Funtion
  void checkRememberMe(bool newValue) {
    rememberMe = newValue;
    update();
    Logger().i(
      "The Value of Remember Me is : ${rememberMe}",
      time: DateTime.timestamp(),
    );
  }

  // Email Validation
  bool isEmailValid(String email) {
    String emailRegex = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  // Password Validation Function
  bool isPasswordValid(String password) {
    // Define your password strength criteria here
    // For example, at least 8 characters, one uppercase letter, one lowercase letter, and one digit
    String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
    RegExp regExp = RegExp(passwordRegex);
    return regExp.hasMatch(password);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    //Get.delete<Controller>();
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    ownerNameController.dispose();
    ownerContentNumberController.dispose();
    ownerEmailController.dispose();
    BusinessNameController.dispose();
    BusinessTypeController.dispose();
    BusinessAddressController.dispose();
    ownerPasswordController.dispose();
    ownerPasswordConfirmController.dispose();

    forgetPasswordController.dispose();
    pinputController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }

  // Steps of Steeper
  List<Step> steps(LoginController create) {
    return [
      Step(
        title: Text("Personal"),
        content: Column(
          children: [
            CustomTextFeilds(
              hintText: "Enter Owner FullName",
              showPassowrd: false,
              controller: create.ownerNameController,
              iconData: IconlyBroken.profile,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 15),
            CustomTextFeilds(
              hintText: "Enter Owner E-mail",
              showPassowrd: false,
              controller: create.ownerEmailController,
              iconData: IconlyBroken.message,
              isEmail: true,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            CustomTextFeilds(
              hintText: "Enter Owner Contact Phone",
              showPassowrd: false,
              controller: create.ownerContentNumberController,
              iconData: IconlyBroken.call,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      Step(
        title: Text("Business"),
        content: Column(
          children: [
            CustomTextFeilds(
              hintText: "Enter Business Name",
              showPassowrd: false,
              controller: create.BusinessNameController,
              iconData: IconlyBroken.buy,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 15),
            CustomTextFeilds(
              hintText: "Enter Business Type",
              showPassowrd: false,
              controller: create.BusinessTypeController,
              iconData: IconlyBroken.category,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 15),
            CustomTextFeilds(
              hintText: "Enter Business Address",
              showPassowrd: false,
              controller: create.BusinessAddressController,
              iconData: IconlyBroken.location,
              keyboardType: TextInputType.emailAddress,
            )
          ],
        ),
      ),
      Step(
        title: Text("Security"),
        content: Column(
          children: [
            CustomTextFeilds(
              hintText: "Enter Owner Password",
              showPassowrd: create.isCreatepassword,
              controller: create.ownerPasswordController,
              iconData: IconlyBroken.password,
              passIcon: create.isCreatepassword
                  ? IconlyBroken.hide
                  : IconlyBroken.show,
              onTap: () => create.createshowAndHidePassword(),
              ispassword: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            CustomTextFeilds(
              hintText: "Enter Owner Confirm Password",
              showPassowrd: create.isCreatepassword,
              controller: create.ownerPasswordConfirmController,
              iconData: IconlyBroken.password,
              passIcon: create.isCreatepassword
                  ? IconlyBroken.hide
                  : IconlyBroken.show,
              onTap: () => create.createshowAndHidePassword(),
              ispassword: true,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    ];
  }

  void onSave(String number) {
    print(number);
  }
}
