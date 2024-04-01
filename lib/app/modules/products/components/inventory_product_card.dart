import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../../data/product_model.dart';
import '../views/product_detail_screen.dart';

class InvontryOrProductCard extends StatelessWidget {
  const InvontryOrProductCard({
    super.key,
    required this.pro,
  });

  final ProductModel pro;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailScreen(pro: pro),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            Get.isDarkMode
                ? BoxShadow()
                : BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                  )
          ],
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                  imageUrl: "${pro.thumbnail}",
                  height: 80,
                  width: 80,
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
                        height: 80,
                        width: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Image.network(
                      "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${pro.title}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${moneyFormater(pro.price).compactSymbolOnLeft}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: pro.stock! < 40
                        ? Colors.orange.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("Stock ${pro.stock}"),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.055),
                GetBuilder<ProductsController>(builder: (rf) {
                  return GestureDetector(
                    onTap: () {
                      rf.updateOpen();
                    },
                    child: Icon(
                      Iconsax.more_circle,
                    ),
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
