import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/suppliers/controllers/suppliers_controller.dart';
import 'package:pos_manangement_app/app/modules/suppliers/views/supplier_detail.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../models/suppiler_model.dart';

class SupplierCard extends StatelessWidget {
  const SupplierCard({
    super.key,
    required this.sup,
  });

  final SupplierModel sup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => SupplierDetails(
            model: sup,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 8),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                // image: DecorationImage(
                //   image: NetworkImage(
                //     "${sup.thumbnail}",
                //   ),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: GetBuilder<SuppliersController>(builder: (spp) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Hero(
                    tag: sup.isNetwork == true
                        ? "${sup.thumbnail}"
                        : "${sup.thumbnail}",
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: sup.isNetwork == true
                              ? CachedNetworkImageProvider(
                                  //CachedNetworkImage
                                  "${sup.thumbnail}",
                                  // height: 90,
                                  // width: 90,
                                  // placeholder: (context, url) => Container(
                                  //   //height: 100.0,
                                  //   //margin: const EdgeInsets.all(12),
                                  //   //margin: EdgeInsets.only(bottom: 12),

                                  //   child: Shimmer.fromColors(
                                  //     baseColor: Get.isDarkMode
                                  //         ? Color(0xff3f3f3f)
                                  //         : Colors.grey[300]!,
                                  //     highlightColor:
                                  //         Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
                                  //     child: Container(
                                  //       height: 90,
                                  //       width: 90,
                                  //       color: Colors.grey,
                                  //     ),
                                  //   ),
                                  // ),
                                  // errorWidget: (context, url, error) {
                                  //   return Image.network(
                                  //     "https://nayemdevs.com/wp-content/uploads/2020/03/default-product-image.png",
                                  //   );
                                  // },
                                  //fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(
                                    sup.thumbnail.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${sup.companyName}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${sup.contentPerson}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "C. Person Phone",
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "${sup.tellephoneOne}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Campnay Phone",
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "${sup.tellephoneOne}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
