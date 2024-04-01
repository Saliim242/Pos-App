import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:pos_manangement_app/app/modules/Favourite/controllers/favourite_controller.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../../data/product_model.dart';
import '../controllers/products_controller.dart';
import '../views/product_detail_screen.dart';
import 'category_and_stocks.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({
    super.key,
    required this.product,
    this.onTap,
  });

  final ProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ProductsController>().updateImage(0);
        Get.to(
          () => ProductDetailScreen(pro: product),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.8,
        // padding: EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
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
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8)
                      // only(
                      //   bottomLeft: Radius.circular(8),
                      //   bottomRight: Radius.circular(8),
                      // )
                      ,
                      child: Hero(
                        tag: "${product.thumbnail}",
                        child: CachedNetworkImage(
                          imageUrl: "${product.thumbnail}",
                          // "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => Container(
                            //height: 100.0,
                            //margin: const EdgeInsets.all(12),
                            //margin: EdgeInsets.only(bottom: 12),

                            child: Shimmer.fromColors(
                              baseColor: Get.isDarkMode
                                  ? Color(0xff3f3f3f)
                                  : Colors.grey[300]!,
                              highlightColor: Get.isDarkMode
                                  ? Colors.white10
                                  : Colors.grey[100]!,
                              child: Container(
                                height: 110,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    "${product.title}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  CategoryTypeAndStockLength(
                    iconData: IconlyBroken.category,
                    title: 'Brand : ${product.brand}',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CategoryTypeAndStockLength(
                    iconData: IconlyBroken.discovery,
                    title: 'Stock : ${product.stock}',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${moneyFormater(double.parse(product.price.toString())).compactSymbolOnLeft}",
                          style: TextStyle().copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                        GetBuilder<CartsController>(
                          builder: (cart) {
                            return GestureDetector(
                              onTap: () {
                                log("Added To de Cart");
                                cart.saveCartsProducts(product);
                                cart.getcartsPrice(product);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.kJtechPrimaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  //topLeft: Radius.circular(12),
                                  //  bottomRight: Radius.circular(16),
                                ),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Iconsax.add,
                                      color: AppColor.kbgColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: 15,
              child: GetBuilder<FavouriteController>(
                builder: (fr) {
                  return GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      // margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColor.kbgColor.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: GetBuilder<FavouriteController>(
                          builder: (cont) {
                            return LikeButton(
                              onTap: (isLiked) async {
                                if (!isLiked) {
                                  cont.saveFavoriteCourse(product);
                                  return true;
                                } else {
                                  cont.removeFavoriteCourse(product);
                                  return false;
                                }
                              },
                              isLiked: cont.checkCourseInFavorite(product),
                              size: 20,
                              likeBuilder: (bool isLiked) {
                                if (!isLiked) {
                                  return Icon(
                                    CupertinoIcons.heart,
                                    //size: 20,
                                    color: Get.isDarkMode
                                        ? Colors.grey
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
                  );
                },
              ),
            ),
            Positioned(
              right: 15,
              top: MediaQuery.of(context).size.height * 0.11,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xffEAC612).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.star_1,
                      color: AppColor.kJtechPrimaryColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${product.rating ?? 0}",
                      style: TextStyle(
                        color: AppColor.kJtechPrimaryColor,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
