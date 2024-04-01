import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../../data/product_model.dart';

class CartsCardView extends StatelessWidget {
  const CartsCardView({
    super.key,
    required this.pro,
    this.increment,
    this.decrement,
  });

  final ProductModel pro;
  final void Function()? increment;
  final void Function()? decrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          Get.isDarkMode
              ? BoxShadow()
              : BoxShadow(
                  color: AppColor.kJtechPrimaryColor.withOpacity(0.2),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/Profile.jpeg'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl: pro.thumbnail ??
                    "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                height: 90,
                width: 90,
                placeholder: (context, url) => Container(
                  //height: 90.0,
                  //margin: const EdgeInsets.all(12),
                  //margin: EdgeInsets.only(bottom: 12),

                  child: Shimmer.fromColors(
                    baseColor:
                        Get.isDarkMode ? Color(0xff3f3f3f) : Colors.grey[300]!,
                    highlightColor:
                        Get.isDarkMode ? Colors.white10 : Colors.grey[90]!,
                    child: Container(
                      height: 90,
                      width: 90,
                      color: Colors.grey,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${pro.title}",
                  style: TextStyle(
                    fontSize: 17,
                    color: Get.isDarkMode
                        ? AppColor.kbgColor
                        : AppColor.kJtechPrimaryColor,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      IconlyBroken.category,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${pro.category}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      //flex: 2,
                      child: Text(
                        "${moneyFormater(double.parse(pro.price.toString())).compactSymbolOnLeft}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: decrement,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.kJtechPrimaryColor,
                              ),
                              child: Icon(
                                Iconsax.minus,
                                color: AppColor.kbgColor,
                                size: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              //pro.quantity.toString()
                              "${pro.quantity.toString()}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: increment,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.kJtechSecondColor,
                              ),
                              child: Icon(
                                Iconsax.add,
                                color: AppColor.kbgColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
