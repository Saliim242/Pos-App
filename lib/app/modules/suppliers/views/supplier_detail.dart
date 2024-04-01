import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/suppliers/controllers/suppliers_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';
import '../models/suppiler_model.dart';

class SupplierDetails extends StatelessWidget {
  const SupplierDetails({super.key, required this.model});

  final SupplierModel model;

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
            'Suppllier Details',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: model.isNetwork == true
                        ? "${model.thumbnail}"
                        : "${model.thumbnail}",
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: model.isNetwork == true
                                  ? CachedNetworkImageProvider(
                                      "${model.thumbnail}")
                                  : Image.file(
                                      File(
                                        model.thumbnail.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )

                        // CachedNetworkImage(
                        //   imageUrl: "${model.thumbnail}",
                        //   height: 350,
                        //   width: MediaQuery.of(context).size.width,
                        //   placeholder: (context, url) => Container(
                        //     child: Shimmer.fromColors(
                        //       baseColor: Get.isDarkMode
                        //           ? Color(0xff3f3f3f)
                        //           : Colors.grey[300]!,
                        //       highlightColor: Get.isDarkMode
                        //           ? Colors.white10
                        //           : Colors.grey[100]!,
                        //       child: Container(
                        //         height: 350,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ),
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                model.companyName ?? "Lama Hayo",
                style: TextStyle(
                  fontSize: 17,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
                maxLines: 2,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                model.description ?? "Lama Hayo",
                style: TextStyle(
                  fontSize: 17,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
                maxLines: 2,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CampanyDestails(
                          title: "Content Person Name",
                          subtitle: "${model.contentPerson}",
                        ),
                      ),
                      Expanded(
                        child: CampanyDestails(
                          title: "Content Person Phone",
                          subtitle: "${model.tellephoneOne}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.55),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CampanyDestails(
                          title: "Campanay Phone Number",
                          subtitle: "${model.tellephoneTwo}",
                        ),
                      ),
                      Expanded(
                        child: CampanyDestails(
                          title: "Campanay Email",
                          subtitle: "${model.contactEmail}",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.55),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CampanyDestails(
                        title: "Campanay Address",
                        subtitle: "${model.campanyAddress}",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SignInBtn(
                  text: "Contect to the Campanay",
                  onPressed: () {
                    showModalBottomSheet(
                      //showDragHandle: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0),
                        ),
                      ),
                      backgroundColor: Get.isDarkMode
                          ? Theme.of(context).cardColor
                          : Colors.white,
                      context: context,
                      builder: (builder) {
                        return ReusableSocialMedia(
                          phone: model.tellephoneTwo.toString(),
                          whatsapp: model.tellephoneTwo.toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CreateAccount(
                  text: "Contect to the person",
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableSocialMedia extends StatelessWidget {
  const ReusableSocialMedia({
    super.key,
    required this.phone,
    required this.whatsapp,
  });

  final String phone;
  final String whatsapp;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersController>(builder: (sup) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How do you like to contact Us ?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SupplierSocilaMediaContatcs(
                        icon: FontAwesomeIcons.whatsapp,
                        title: "Whats'App",
                        onTap: () => sup.WhatsAppContact(whatsapp),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SupplierSocilaMediaContatcs(
                        icon: Iconsax.call_calling,
                        title: "Call Us",
                        onTap: () => sup.makeCallPhone(phone),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SupplierSocilaMediaContatcs(
                        icon: FontAwesomeIcons.googlePlusG,
                        title: "Gmail",
                        onTap: () async => await sup.sendEmail(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SupplierSocilaMediaContatcs extends StatelessWidget {
  const SupplierSocilaMediaContatcs({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.isDarkMode
              ? AppColor.kThirdDarkColor
              : Color(0xffEAF4FD).withOpacity(0.2),
          border: Border.all(
            color: Get.isDarkMode
                ? AppColor.kSecondDarkColor
                : AppColor.kTexMoneyColor,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color:
                  Get.isDarkMode ? AppColor.kbgColor : AppColor.kTexMoneyColor,
              size: 28,
            ),
            SizedBox(height: 8),
            Text(
              "${title}",
              style: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kTexMoneyColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CampanyDestails extends StatelessWidget {
  const CampanyDestails({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(
            fontSize: 14,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
        SizedBox(height: 3),
        Text(
          "${subtitle}",
          style: TextStyle(
            fontSize: 13,
            color: Get.isDarkMode
                ? AppColor.kbgColor.withOpacity(0.89)
                : AppColor.kJtechPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
