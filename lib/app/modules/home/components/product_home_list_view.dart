import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/constants.dart';
import '../../components/custom_error_screens.dart';
import '../../products/components/product_list_view_card.dart';
import '../../products/components/product_list_view_data_loading.dart';
import '../../products/controllers/products_controller.dart';

class ProductHomeListViewWidget extends StatelessWidget {
  const ProductHomeListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (pr) {
        if (pr.isLoadingProduct) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context)
            //             .size
            //             .height *
            //         0.1),
            itemCount: 6,

            itemBuilder: (context, index) => LoadingProductsListViewData(),
          );
        } else if (pr.isNoInternet) {
          return Center(
            child: Text("No Internet Connection Please Connect "),
          );
        } else if (pr.products.isEmpty) {
          return Center(
            child: GestureDetector(
              onTap: () => pr.getProducts(),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    LottieBuilder.asset(
                      'assets/animations/empty.json',
                      animate: true,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Oops! It seems there are no products found matching your search. Please try a different keyword or browse our categories for exciting options.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return pr.foundProductsList.isNotEmpty
            ? AnimatedContainer(
                duration: Duration(milliseconds: 375),
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.08),
                    itemCount: pr.foundProductsList.length,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredGrid(
                      duration: const Duration(milliseconds: 375),
                      columnCount: pr.foundProductsList.length,
                      position: index,
                      child: ScaleAnimation(
                        delay: const Duration(milliseconds: 200),
                        // horizontalOffset: 50,
                        // verticalOffset: 50.0,
                        child: ScaleAnimation(
                          delay: const Duration(milliseconds: 300),
                          child: ProductListViewCard(
                            pro: pr.foundProductsList[index],
                          ),
                          // ProductCardView(
                          //   product:
                          //       pr.foundProductsList[
                          //           index],
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: CustomEmplyScreen(
                  img: "assets/animations/empty.json",
                  content:
                      " No products found. Explore other options or refine your search for a perfect match",
                ),
              );
      },
    );
  }
}
