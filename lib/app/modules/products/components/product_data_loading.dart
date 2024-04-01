import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';

class LoadingProducts extends StatelessWidget {
  const LoadingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.0,
      //margin: const EdgeInsets.all(12),
      //margin: EdgeInsets.only(bottom: 12),

      child: Shimmer.fromColors(
        baseColor: Get.isDarkMode ? Color(0xff3f3f3f) : Colors.grey[300]!,
        highlightColor: Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                height: 15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 6),
              Container(
                height: 15,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      //topLeft: Radius.circular(12),
                      //  bottomRight: Radius.circular(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


























/*

Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    height: 15,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kJtechPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15,
                              // width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 15,
                              //width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15,
                              // width: MediaQuery.of(context).size.width * 0.03,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 15,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )

*/