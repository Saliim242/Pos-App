import 'dart:developer';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:pos_manangement_app/app/modules/suppliers/models/suppiler_model.dart';
import 'package:pos_manangement_app/app/modules/suppliers/providers/supplier_provider.dart';
import 'package:pos_manangement_app/constants/display_message_errors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/constants.dart';

class SuppliersController extends GetxController {
  final TextEditingController supplierCampnayName = TextEditingController();
  final TextEditingController supplierDescription = TextEditingController();
  final TextEditingController supplierContentPerson = TextEditingController();
  final TextEditingController supplierTellePhoneOne = TextEditingController();
  final TextEditingController supplierTellePhoneTwo = TextEditingController();
  final TextEditingController supplierCampanyAddress = TextEditingController();
  final TextEditingController supplierContactEmail = TextEditingController();
  final TextEditingController supplierthumbnail = TextEditingController();

  final suppFormKey = GlobalKey<FormState>();
  List<SupplierModel> suppliers = [];
  bool isSupplierLoading = false;

  // Load All Our Customers Function
  loadSuppliers() async {
    try {
      isSupplierLoading = true;
      update();
      // if (customers.isEmpty) {
      //   isCustomerLoading = true;
      //   update();
      // }

      await Future.delayed(Duration(seconds: 2));

      suppliers = await SupplierProvider().getSuppliers();

      update();
    } catch (e) {
      print("Customers are ${suppliers.toString()}");
      suppliers = [];

      update();
    }

    // finally {
    //   isSupplierLoading = false;
    //   update();
    // }
    isSupplierLoading = false;
    update();
  }

  final box1 = GetStorage();

  final String kSupplier = 'suppe';

  Future<void> getSuppliersCampany() async {
    if (box1.hasData(kSupplier)) {
      var data = await box1.read(kSupplier);

      for (var v in data) {
        suppliers.add(
          SupplierModel.fromJson(Map<String, dynamic>.from(v)),
        );
      }
      update();
    }
  }

  // Add New Supplier
  void AddNewSupplier() async {
    if (suppFormKey.currentState!.validate()) {
      SupplierModel newsu = SupplierModel(
        id: suppliers.length + 1,
        companyName: supplierCampnayName.text.trim(),
        campanyAddress: supplierCampanyAddress.text.trim(),
        contactEmail: supplierContactEmail.text.trim(),
        contentPerson: supplierContentPerson.text.trim(),
        description: supplierDescription.text.trim(),
        tellephoneOne: int.parse(supplierTellePhoneOne.text.trim()),
        tellephoneTwo: int.parse(supplierTellePhoneTwo.text.trim()),
        thumbnail: box.read('supp'),
        isNetwork: false,
      );

      //: "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png");

      //var supt = suppliers.add(newsu);

      suppliers.add(newsu);
      update();
      final products = suppliers.map((v) => v.toJson()).toList();
      await box1.write(kSupplier, products);
      // await box1.write(
      //     'new',
      //     suppliers
      //         .map(
      //           (sup) => sup.toJson(),
      //         )
      //         .toList());

      update();

      showSnackBars(
        context: Get.context!,
        contentType: ContentType.success,
        title: "Yes",
        message: "You Caqn 🛍️✨",
      );

      box.remove('supp');
    }
    // else if (box.read('supp') != null) {
    //   final String img =
    //       "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png";
    //   box.write('supp', img);

    //   // showSnackBars(
    //   //   context: Get.context!,
    //   //   contentType: ContentType.failure,
    //   //   title: "🚀OPPS!",
    //   //   message: "Please Pick Up Campany Logo 🛍️✨",
    //   // );

    //   log("Saalim Abukar");
    // }

    else {
      showSnackBars(
        context: Get.context!,
        contentType: ContentType.failure,
        title: "Oops!",
        message:
            "Don't Forget to Fill in All Fields Before Adding the New Supplier. Every Detail Counts! 🛍️✨",
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    //await box1.read(kSupplier);
    loadSuppliers();
  }

  @override
  void dispose() {
    supplierCampnayName.dispose();
    supplierDescription.dispose();
    supplierContentPerson.dispose();
    supplierTellePhoneOne.dispose();
    supplierTellePhoneTwo.dispose();
    supplierCampanyAddress.dispose();
    supplierContactEmail.dispose();
    supplierthumbnail.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Campnay Logo Or Image Picker

  final box = GetStorage();
  File? imageFile;
  final pickImage = ImagePicker();

  pickCampanyLogo() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      await pickImage
          .pickImage(source: ImageSource.gallery, imageQuality: 100)
          .then(
        (value) {
          if (value != null) {
            _cropImagePicked(File(value.path));
            log("Image Path is ${value}");
          }
        },
      );
    } else if (status.isDenied) {
      status = await Permission.storage.request();

      if (status.isDenied) {
        // Permission is still denied after the request
        showSnackBars(
          context: Get.context!,
          contentType: ContentType.help,
          title: "Permission is denied!",
          message:
              "It seems you denied access to your gallery. To pick an image, please enable gallery access in your app settings.",
        );

        // Open app settings to allow the user to enable the permission
        // openAppSettings();
        showSnackBars(
          context: Get.context!,
          contentType: ContentType.help,
          title: "Permission is denied !",
          message:
              "It seems you denied access to your gallery. To pick an image, please enable gallery access in your app settings.",
        );
      }
    }
  }

  _cropImagePicked(File imagePath) async {
    final cropeImg = await ImageCropper().cropImage(
      sourcePath: imagePath.path,
      compressQuality: 100,
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: Get.isDarkMode
              ? AppColor.kJtechPrimaryColor
              : AppColor.kJtechSecondColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        )
      ],
    );

    if (cropeImg != null) {
      imageCache.clear();
      imageFile = File(cropeImg.path);
      box.write("supp", imageFile!.path);
      update();
    }
  }

  /// Social Media Contact Suppliers

  // Whats App

  void WhatsAppContact(String phoneNumber) async {
    log("Phone Number $phoneNumber");

    final String message = "Asc Walal Wan U Bahnay Cawinaad ";
    final Uri url =
        Uri.parse("whatsapp://send?phone=252$phoneNumber&text=$message");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Phone Number $phoneNumber");
      Fluttertoast.showToast(
        msg: "No What's App Found",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            Get.isDarkMode ? AppColor.kThirdDarkColor : Colors.grey.shade300,
        textColor:
            Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        fontSize: 16.0,
      );
    }

    // if (await canLaunch(url as String)) {
    //   await launch(url);
    // } else {
    //   print('Could not launch $url');
    // }
  }

  // Call
  void makeCallPhone(String phoneNumber) async {
    PermissionStatus status = await Permission.phone.request();
    if (status.isGranted) {
      // Permission is granted, you can access the device ID
      final Uri url = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print('No phone apps found');
      }
    } else if (status.isDenied) {
      // Permission is denied, handle it accordingly
      Get.snackbar(
        "",
        "",
        titleText: Text(
          "Permission is denied",
          style: TextStyle(
            fontSize: 16,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        messageText: Text(
          "Permission is denied Please Grant to the permissin ",
          style: TextStyle(
            fontSize: 12,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),

        backgroundColor: Get.isDarkMode
            ? AppColor.kThirdDarkColor
            : AppColor.kJtechSecondColor.withOpacity(0.2),
        snackPosition: SnackPosition.BOTTOM,
        //animationDuration: Duration(seconds: 1),
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {},
          child: Text("Ok"),
        ),
        margin: EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, take appropriate action (e.g., show settings dialog)
      Get.snackbar(
        "",
        "",
        titleText: Text(
          "Permission is permanently denied",
          style: TextStyle(
            fontSize: 16,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        messageText: Text(
          " Permission is permanently denied please Go to setting and allow the permission to make calls.",
          style: TextStyle(
            fontSize: 12,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),

        backgroundColor: Get.isDarkMode
            ? AppColor.kThirdDarkColor
            : AppColor.kJtechSecondColor.withOpacity(0.2),
        snackPosition: SnackPosition.BOTTOM,
        //animationDuration: Duration(seconds: 1),
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () async {
            // await AppSettings.openAppSettings();
          },
          child: Text("Open Setting"),
        ),
        margin: EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }

    // final Url url = "tel:$phoneNumber";
  }

  // Gmail

  sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'salim7442a@gmail.com',
      queryParameters: {
        'subject': 'JTech Point of Sale',
        'body': 'Welcome back',
      },
    );

    if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
      await canLaunchUrl(Uri.parse(emailLaunchUri.toString()));
    } else {
      print('Could not launch email');
    }
  }

  /// Supplier Save Local Data base Datat
  ///
  ///
}
