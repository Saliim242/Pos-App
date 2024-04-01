import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import 'package:pos_manangement_app/app/modules/suppliers/controllers/suppliers_controller.dart';

import '../../../../constants/constants.dart';
import '../components/adding_new_supp_textfeilds.dart';

class AddNewSupplier extends StatelessWidget {
  const AddNewSupplier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Theme.of(Get.context!).scaffoldBackgroundColor,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Add New Supplier',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Iconsax.back_square,
            //IconlyBroken.more_square,
            //color: Get.theme.hoverColor,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<SuppliersController>(
        builder: (addSup) {
          return Form(
            key: addSup.suppFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierCampnayName,
                        hintText: "Campnay Name",
                        iconData: Iconsax.building_4,
                        keyboardType: TextInputType
                            .name, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierContentPerson,
                        hintText: "Content Person Name",
                        iconData: IconlyBroken.profile,
                        keyboardType: TextInputType
                            .name, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierTellePhoneOne,
                        hintText: "Campnay Phone Number",
                        iconData: IconlyBroken.call,
                        keyboardType: TextInputType
                            .phone, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierTellePhoneTwo,
                        hintText: "Content Person Phone Number",
                        iconData: IconlyBroken.call,
                        keyboardType: TextInputType
                            .phone, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierContactEmail,
                        hintText: "Campnay E-mail Address",
                        iconData: IconlyBroken.message,
                        keyboardType: TextInputType.emailAddress,
                        isEmail: true, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      AddSupplierTextFeilds(
                        controller: addSup.supplierCampanyAddress,
                        hintText: "Campnay Address",
                        iconData: IconlyBroken.location,
                        keyboardType: TextInputType
                            .name, //TextInputType.numberWithOptions(),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      Text(
                        "Choose Campany Logo or Image",
                        style: TextStyle(
                          fontSize: 15,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.022),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            log("Upload Campnay Logo");
                            addSup.pickCampanyLogo();
                          },
                          child: Container(
                            height: 130,
                            width: 135,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: addSup.box.read('supp') == null
                                    ? CachedNetworkImageProvider(
                                        "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                                      )
                                    : Image.file(
                                        File(
                                          addSup.box.read('supp'),
                                        ),
                                        fit: BoxFit.cover,
                                      ).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SignInBtn(
                          text: "Create New Supplier",
                          onPressed: () {
                            addSup.AddNewSupplier();
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
