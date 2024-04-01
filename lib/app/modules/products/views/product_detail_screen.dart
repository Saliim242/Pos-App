import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/data/product_model.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/app/modules/home/controllers/home_controller.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';
import 'package:pos_manangement_app/app/modules/products/views/product_image_view.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../Favourite/controllers/favourite_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.pro}) : super(key: key);
  final ProductModel pro;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctr) {
      return Scaffold(
        appBar: AppBar(
          elevation: Get.isDarkMode ? 0.5 : 0.5,
          backgroundColor: //Theme.of(Get.context!).primaryColor,
              Get.isDarkMode
                  ? Theme.of(Get.context!).cardColor
                  : Theme.of(Get.context!).scaffoldBackgroundColor,
          centerTitle: true,
          title: Marquee(
            child: Text(
              'Product Details',
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
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
        ),
        body: GetBuilder<ProductsController>(builder: (cont) {
          return ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // All Images and Icons
                        Stack(
                          children: [
                            Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ProductPhotoView(
                                      image: getImage(cont.currentImage) ??
                                          "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png", //"${pro.thumbnail}",
                                      id: "${getImage(cont.currentImage)}",
                                    ),
                                  );
                                },
                                child: Container(
                                  //margin: EdgeInsets.all(15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Hero(
                                      tag:
                                          "${pro.thumbnail}", //getImage(cont.currentImage)
                                      // "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                            imageUrl: getImage(
                                                    cont.currentImage) ??
                                                "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                                            height: 360,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            placeholder: (context, url) =>
                                                Container(
                                              //height: 100.0,
                                              //margin: const EdgeInsets.all(12),
                                              margin:
                                                  EdgeInsets.only(bottom: 12),

                                              child: Shimmer.fromColors(
                                                baseColor: Get.isDarkMode
                                                    ? Color(0xff3f3f3f)
                                                    : Colors.grey[300]!,
                                                highlightColor: Get.isDarkMode
                                                    ? Colors.white10
                                                    : Colors.grey[100]!,
                                                child: Container(
                                                  height: 360,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 15,
                              //top: 15,
                              left: 8,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor.withOpacity(0.55)
                                      : Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 75,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: pro.images?.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        cont.updateImage(index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: cont.currentImage == index
                                                  ? AppColor.kJtechSecondColor
                                                  : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: getImage(index) ??
                                                    "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                                                width: 65,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  //height: 100.0,
                                                  //margin: const EdgeInsets.all(12),
                                                  //margin: EdgeInsets.only(bottom: 12),

                                                  child: Shimmer.fromColors(
                                                    baseColor: Get.isDarkMode
                                                        ? Color(0xff3f3f3f)
                                                        : Colors.grey[300]!,
                                                    highlightColor:
                                                        Get.isDarkMode
                                                            ? Colors.white10
                                                            : Colors.grey[100]!,
                                                    child: Container(
                                                      width: 65,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              )

                                              // Image(
                                              //   image: NetworkImage(
                                              //       getImage(index) ?? "Waa lawaye"),

                                              //   //{pro.images?[index] ?? ""}
                                              //   fit: BoxFit.cover,
                                              //   width: 65,
                                              // ),
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                //margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Get.isDarkMode
                                      ? AppColor.kSecondDarkColor
                                      : Colors.grey.shade200,
                                  // borderRadius: BorderRadius.circular(8),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Get.isDarkMode
                                          ? AppColor.kSecondDarkColor
                                          : AppColor.kJtechPrimaryColor
                                              .withOpacity(0.2),
                                      offset: Offset(1, 1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: GetBuilder<FavouriteController>(
                                    builder: (cont) {
                                      return LikeButton(
                                        onTap: (isLiked) async {
                                          if (!isLiked) {
                                            cont.saveFavoriteCourse(pro);
                                            return true;
                                          } else {
                                            cont.removeFavoriteCourse(pro);
                                            return false;
                                          }
                                        },
                                        isLiked:
                                            cont.checkCourseInFavorite(pro),
                                        size: 25,
                                        likeBuilder: (bool isLiked) {
                                          if (!isLiked) {
                                            return Icon(
                                              IconlyBroken.heart,
                                              //size: 20,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColor.kJtechSecondColor,
                                            );
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                pro.title ?? "Lama Hayo",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechPrimaryColor,
                                ),
                                //maxLines: 2,
                              ),
                            ),
                            Text(
                              "${moneyFormater(double.parse(pro.price.toString())).compactSymbolOnLeft}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),

                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? AppColor.kThirdDarkColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProductDetailsCategoryAndStock(
                                    icon: IconlyBroken.category,
                                    title: pro.category ?? "",
                                  ),
                                  ProductDetailsCategoryAndStock(
                                    icon: IconlyBroken.discovery,
                                    title: "Stock: ${pro.stock ?? "0"}",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProductDetailsCategoryAndStock(
                                    icon: IconlyBroken.star,
                                    title: "${pro.rating ?? "0"}",
                                  ),
                                  ProductDetailsCategoryAndStock(
                                    icon: IconlyBroken.discovery,
                                    title: "Brand: ${pro.brand ?? "0"}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),

                        // Location and Rate
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.013),
                        Row(
                          children: [
                            Expanded(
                              child: ExpandableText(
                                "${pro.description ?? ""}",
                                animation: true,
                                animationCurve: Curves.easeIn,
                                expandText: 'show more',
                                collapseText: 'show less',
                                maxLines: 3,
                                linkColor: Colors.blue,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(12),
          height: 80,
          //width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: Get.isDarkMode
                ? AppColor.kSecondDarkColor
                : Colors.grey.shade300,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${moneyFormater(double.parse(pro.price.toString())).compactSymbolOnLeft}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechSecondColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<CartsController>(builder: (crt) {
                return GestureDetector(
                  onTap: crt.checkCartsInCart(pro)
                      ? () {
                          crt.removeCartItems(pro);
                          crt.getRemovedCartsPrice(pro);
                        }
                      : () {
                          log("Add To The Cart Page");
                          crt.saveCartsProducts(pro);
                          crt.getcartsPrice(pro);
                        },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColor.kThirdDarkColor
                          : AppColor.kJtechSecondColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyBroken.bag,
                          color: AppColor.kbgColor,
                          size: 25,
                        ),
                        SizedBox(width: 8),
                        Text(
                          crt.checkCartsInCart(pro)
                              ? "Remove it"
                              : "Add To Cart",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.kbgColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  getImage(int index) {
    if (pro.images != null && pro.images!.isNotEmpty) {
      return pro.images![index];
    } else {
      return pro.thumbnail;
    }
  }
}

class ProductDetailsCategoryAndStock extends StatelessWidget {
  const ProductDetailsCategoryAndStock({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color:
              Get.isDarkMode ? AppColor.kbgColor : AppColor.kJtechPrimaryColor,
        ),
        SizedBox(width: 4),
        Text(
          "${title}",
          style: TextStyle(
            fontSize: 15,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ],
    );
  }
}
