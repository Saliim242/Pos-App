import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import 'package:pos_manangement_app/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomersController cont = Get.put(CustomersController());
    return ListView.builder(
      itemCount: cont.customers.length,
      shrinkWrap: true, // Set the number of shimmer items
      itemBuilder: (context, index) {
        return Container(
          //height: 100.0,
          //margin: const EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 12),

          child: Shimmer.fromColors(
            baseColor: Get.isDarkMode ? Color(0xff3f3f3f) : Colors.grey[300]!,
            highlightColor: Get.isDarkMode ? Colors.white10 : Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 40,
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
        );
      },
    );
  }
}




    // ListTile(
    //         leading: CircleAvatar(
    //           backgroundColor: Colors.white,
    //           radius: 30,
    //         ),
    //         title: Container(
    //           height: 20,
    //           color: Colors.white,
    //         ),
    //         subtitle: Container(
    //           height: 15,
    //           color: Colors.white,
    //         ),
    //       ),