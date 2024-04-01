import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../../data/product_model.dart';
import '../../carts/controllers/carts_controller.dart';
import '../controllers/products_controller.dart';
import '../views/product_detail_screen.dart';

class ProductListViewCard extends StatelessWidget {
  const ProductListViewCard({super.key, required this.pro});

  final ProductModel pro;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<ProductsController>().updateImage(0);
        Get.to(
          () => ProductDetailScreen(pro: pro),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 12),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Hero(
                  tag: "${pro.thumbnail}",
                  child: CachedNetworkImage(
                    imageUrl: "${pro.thumbnail}",
                    // "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                    height: 110,
                    width: 110,

                    placeholder: (context, url) => Container(
                      //height: 100.0,
                      //margin: const EdgeInsets.all(12),
                      //margin: EdgeInsets.only(bottom: 12),

                      child: Shimmer.fromColors(
                        baseColor: Get.isDarkMode
                            ? Color(0xff3f3f3f)
                            : Colors.grey[300]!,
                        highlightColor:
                            Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
                        child: Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${pro.title}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingBarIndicator(
                          rating: pro.rating!,
                          itemCount: pro.rating!.toInt(),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          itemSize: 15,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${pro.rating}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconlyBroken.category,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${pro.category}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconlyBroken.discovery,
                          size: 15,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${pro.stock} In Stock",
                          style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kJtechPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   child: VerticalDivider(
            //     color: Colors.black,
            //     thickness: 2,
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "${moneyFormater(double.parse(pro.price.toString())).compactSymbolOnLeft}",
                      style: TextStyle().copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kTexMoneyColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    GetBuilder<CartsController>(
                      builder: (cart) {
                        return GestureDetector(
                          onTap: cart.checkCartsInCart(pro)
                              ? () {
                                  cart.showToast(
                                      "This ${pro.title} is already in the cart! please check it");
                                  // cart.showRemovingItemConfirmationDialog(pro);
                                }
                              : () {
                                  log("Added To de Cart");
                                  cart.saveCartsProducts(pro);
                                  cart.getcartsPrice(pro);
                                  // cart.sumCart();
                                },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.kJtechPrimaryColor,
                              borderRadius: BorderRadius.circular(5),
                              //topLeft: Radius.circular(12),
                              //  bottomRight: Radius.circular(16),
                            ),
                            child: SizedBox(
                              child: Text(
                                cart.checkCartsInCart(pro)
                                    ? "Remove it"
                                    : "Add to Cart",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
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
