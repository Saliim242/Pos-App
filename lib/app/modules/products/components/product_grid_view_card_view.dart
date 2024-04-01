import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:pos_manangement_app/app/modules/products/views/product_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../../data/product_model.dart';
import '../../Favourite/controllers/favourite_controller.dart';
import '../../carts/controllers/carts_controller.dart';
import '../controllers/products_controller.dart';

class NewProductCardWidget extends StatelessWidget {
  const NewProductCardWidget({
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
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Hero(
                      tag: "${product.thumbnail}",
                      child: CachedNetworkImage(
                        imageUrl: "${product.thumbnail}",
                        // "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                        height: 130,
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
                              height: 130,
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
                SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${product.title}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                        ),
                        //SizedBox(height: 15),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingBarIndicator(
                                rating: product.rating!,
                                itemCount: product.rating!.toInt(),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                itemSize: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${product.rating}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechSecondColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(height: 15),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Iconsax.category,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${product.category}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor
                                      : AppColor.kJtechPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //     height: 20),
                        Expanded(
                          flex: 2,
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
                ),
              ],
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                child: GetBuilder<FavouriteController>(
                  builder: (fr) {
                    return GestureDetector(
                      // onTap: onTap,
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
            ),
          ],
        ),
      ),
    );
  }
}
