import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProductsListViewData extends StatelessWidget {
  const LoadingProductsListViewData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.0,
      //margin: const EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),

      child: Shimmer.fromColors(
        baseColor: Get.isDarkMode ? Color(0xff3f3f3f) : Colors.grey[300]!,
        highlightColor: Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 50,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
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