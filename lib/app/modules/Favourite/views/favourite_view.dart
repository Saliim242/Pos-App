import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/data/product_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/constants.dart';
import '../../components/custom_error_screens.dart';
import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(builder: (empty) {
      return Scaffold(
        appBar: AppBar(
          elevation: Get.isDarkMode ? 0.5 : 0.5,
          backgroundColor: //Theme.of(Get.context!).primaryColor,
              Get.isDarkMode
                  ? Theme.of(Get.context!).cardColor
                  : Colors.grey.shade100,
          centerTitle: true,
          title: Marquee(
            child: Text(
              'Products Favoraties',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                empty.favoriteProducts.isEmpty
                    ? SizedBox()
                    : Text(
                        "Discover Joy in Your Favorites!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                empty.favoriteProducts.isEmpty
                    ? SizedBox()
                    : Text(
                        "Explore your curated collection and experience the magic of your handpicked items. Happy exploring! ✨",
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                GetBuilder<FavouriteController>(
                  builder: (cont) {
                    if (cont.favoriteProducts.isEmpty) {
                      return CustomEmplyScreen(
                        img: 'assets/animations/empty.json',
                        content:
                            'Oops! Your Favorites List is Feeling a Bit Empty! 🌟 Start adding items to create your own personalized collection and let the magic begin!',
                      );
                    } else {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 375),
                        child: AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cont.favoriteProducts.length,
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                              duration: const Duration(milliseconds: 375),
                              position: index,
                              child: ScaleAnimation(
                                delay: const Duration(milliseconds: 200),
                                // horizontalOffset: 50,
                                // verticalOffset: 50.0,
                                child: SlideAnimation(
                                  delay: const Duration(milliseconds: 300),
                                  child: ProductCardListView(
                                    pro: cont.favoriteProducts[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ProductCardListView extends StatelessWidget {
  const ProductCardListView({super.key, required this.pro});

  final ProductModel pro;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                height: 105,
                width: 105,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: "${pro.thumbnail}",
                    height: 105,
                    width: 105,
                    placeholder: (context, url) => Container(
                      //height: 100.0,
                      //margin: const EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 12),

                      child: Shimmer.fromColors(
                        baseColor: Get.isDarkMode
                            ? Color(0xff3f3f3f)
                            : Colors.grey[300]!,
                        highlightColor:
                            Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
                        child: Container(
                          height: 105,
                          width: 105,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Image.network(
                          "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png");
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${pro.title}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                              ),
                            ),
                          ),
                          GetBuilder<FavouriteController>(
                            builder: (fr) {
                              return Center(
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
                                      isLiked: cont.checkCourseInFavorite(pro),
                                      size: 30,
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
                              );
                            },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${moneyFormater(double.parse(pro.price.toString())).compactSymbolOnLeft}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Get.isDarkMode
                                  ? AppColor.kbgColor
                                  : AppColor.kJtechPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
