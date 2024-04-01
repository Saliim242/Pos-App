// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/products/components/add_product_textfield.dart';
import 'package:pos_manangement_app/app/modules/products/views/Add_new_category.dart';

import '../../../../constants/constants.dart';
import '../../login/widgets/widegts.dart';
import '../controllers/products_controller.dart';

class AddNewProducts extends StatelessWidget {
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
            'Add New Product',
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
      body: GetBuilder<ProductsController>(
        builder: (addPr) {
          return Form(
            key: addPr.productformKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  AddProductsTextFeilds(
                    hintText: "Product Name",
                    controller: addPr.productName,
                    iconData: IconlyBroken.category,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: AddProductsTextFeilds(
                          hintText: "Bar Code",
                          controller: addPr.productBarCode,
                          iconData: Iconsax.scan_barcode,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          addPr.scanBarcode();
                        },
                        child: Container(
                          width: 65,
                          height: 65,
                          //padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColor.kJtechPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Iconsax.scan_barcode,
                            color: AppColor.kbgColor,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Category List
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Theme.of(context).cardColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              Get.isDarkMode
                                  ? BoxShadow()
                                  : BoxShadow(
                                      color: Colors.grey.shade400,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                    )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  addPr.CategoryStatus,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kJtechPrimaryColor
                                            .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              DropdownButton(
                                dropdownColor: Get.isDarkMode
                                    ? AppColor.kJtechPrimaryColor
                                    : Colors.grey.shade200,

                                style: TextStyle(
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechPrimaryColor,
                                ),
                                borderRadius: BorderRadius.circular(11),
                                underline: const SizedBox(),
                                items: addPr.categories
                                    .map(
                                      (String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Get.isDarkMode
                                                ? AppColor.kbgColor
                                                : AppColor.kJtechPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                //value: addPr.CategoryStatus,
                                onChanged: (value) =>
                                    addPr.updateCategoryStatus("${value}"),
                                isExpanded: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => AddNewCategoryPage(),
                              fullscreenDialog: true,
                              transition: Transition.downToUp,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            width: 65,
                            height: 65,
                            //padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColor.kJtechPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.add_circle,
                                  color: AppColor.kbgColor,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  // Selling Pricc
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AddProductsTextFeilds(
                    keyboardType: TextInputType.number,
                    hintText: "Selling Price",
                    controller: addPr.productSellingPrice,
                    iconData: Iconsax.dollar_circle,
                    onChanged: (value) => addPr.calculateProfitLoss(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AddProductsTextFeilds(
                    keyboardType: TextInputType.number,
                    hintText: "Cost Price",
                    controller: addPr.productCostPrice,
                    iconData: Iconsax.dollar_circle,
                    onChanged: (value) => addPr.calculateProfitLoss(),
                  ),
                  const SizedBox(height: 4),

                  /// Prodit Or Loss
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          addPr.profitorloss >= 0 ? "Profit : " : "Loss : ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        //  "\$ ${addPr.profitorloss}",
                        Text(
                          addPr.profitorloss >= 0
                              ? '${addPr.profitorloss}'
                              : '${addPr.profitorloss}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : addPr.profitorloss >= 0
                                    ? Color(0xff50c878)
                                    : AppColor.kJtechSecondColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),

                  //SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Product Image
                  Text(
                    "Product Image",
                    style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Image Section
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Theme.of(context).cardColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        Get.isDarkMode
                            ? BoxShadow()
                            : BoxShadow(
                                color: Colors.grey.shade400,
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: addPr.box2.read('custom') == null
                                  ? CachedNetworkImageProvider(
                                      "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                                    )
                                  : Image.file(
                                      File(
                                        addPr.box2.read('custom'),
                                      ),
                                      fit: BoxFit.cover,
                                    ).image,

                              // NetworkImage(
                              //   addPr.box2.read('custom')
                              //   "https://craftsnippets.com/articles_images/placeholder/placeholder.jpg",
                              // ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              //SizedBox(height: 8),
                              ProductAddImage(
                                icon: IconlyBroken.camera,
                                title: "Take a Photo",
                                onTap: () {
                                  addPr.imgFromCamera();
                                  log("Take a Photo", name: "Add Product");
                                },
                              ),
                              SizedBox(height: 8),
                              ProductAddImage(
                                icon: IconlyBroken.image,
                                title: "Choose Photo",
                                onTap: () {
                                  log("Choose a Photo", name: "Add Product");
                                  addPr.imgFromGallery();
                                },
                              ),
                              SizedBox(height: 8),
                              ProductAddImage(
                                icon: Iconsax.gallery_remove,
                                title: "Remove Photo",
                                onTap: () {
                                  log("Remove a Photo", name: "Add Product");
                                  addPr.removeImage();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // SignIn Button
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       "Add Product",
                  //     ),
                  //   ),
                  // ),

                  SignInBtn(
                    text: "Add New Product",
                    onPressed: () {
                      addPr.addNewProduct();

                      //addPr.calculateProfitLoss();
                    },
                  ),

                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductAddImage extends StatelessWidget {
  const ProductAddImage({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final void Function()? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? AppColor.kSecondDarkColor
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icon,
              size: 30,
            ),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
