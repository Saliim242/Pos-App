import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../constants/constants.dart';
import '../controllers/products_controller.dart';

class ProductPhotoView extends StatelessWidget {
  const ProductPhotoView({
    super.key,
    required this.image,
    required this.id,
  });

  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(builder: (pro) {
      return WillPopScope(
        onWillPop: () async {
          if (pro.isDialOpen.value) {
            pro.isDialOpen.value = false;
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          //appBar: AppBar(),
          body: PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: id),
            imageProvider: CachedNetworkImageProvider(
              image,
            )
            // : Image.file(
            //     File(image),
            //     fit: BoxFit.cover,
            //   ).image,
            ,
            backgroundDecoration: BoxDecoration(
              //color: AppColor.kJtechPrimaryColor,
              gradient: LinearGradient(
                colors: [
                  AppColor.kJtechPrimaryColor,
                  AppColor.kJtechSecondColor,
                ],
                // begin: Alignment.bottomCenter,
                // end: Alignment.centerRight,
              ),
            ),
            filterQuality: FilterQuality.high,
          ),
          floatingActionButton: Container(
            height: 55,
            width: 55,
            child: SpeedDial(
              openCloseDial: pro.isDialOpen,
              spacing: 5,
              spaceBetweenChildren: 6,
              heroTag: 'close',
              overlayColor: AppColor.kJtechPrimaryColor,
              overlayOpacity: 0.6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Get.isDarkMode
                  ? AppColor.kJtechSecondColor
                  : AppColor.kJtechPrimaryColor,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(
                color: AppColor.kbgColor,
              ),
              children: [
                SpeedDialChild(
                  elevation: 0,
                  label: "Get Back",
                  onTap: () => Get.back(),
                  //labelWidget: Text("Go Back"),
                  backgroundColor:
                      Get.isDarkMode ? Color(0xff8f263b) : Color(0xff323047),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    IconlyBroken.close_square,
                    color: AppColor.kbgColor,
                    size: 30,
                  ),
                  labelBackgroundColor:
                      Get.isDarkMode ? Color(0xfff05372) : Color(0xff323047),
                  labelStyle: TextStyle(
                    color: AppColor.kbgColor,
                  ),
                ),
                // SpeedDialChild(
                //   labelStyle: TextStyle(
                //     color: AppColor.kbgColor,
                //   ),
                //   elevation: 0,
                //   labelBackgroundColor:
                //       Get.isDarkMode ? Color(0xfff05372) : Color(0xff323047),
                //   //visible: pro.box2.read('custom') == null ? false : true,
                //   label: "Remove ",
                //   onTap: () async {

                //     Get.back();
                //   },
                //   backgroundColor:
                //       Get.isDarkMode ? Color(0xff8f263b) : Color(0xff323047),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Icon(
                //     IconlyBroken.delete,
                //     color: AppColor.kbgColor,
                //     size: 30,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// FloatingActionButton.small(
//             backgroundColor: Get.isDarkMode
//                 ? AppColor.kJtechSecondColor
//                 : AppColor.kJtechPrimaryColor,
//             foregroundColor: AppColor.kbgColor,
//             tooltip: "Go To Home",
//             onPressed: () {
//               Get.back();
//             },
//             child: const Icon(
//               //CupertinoIcons.multiply,
//               IconlyBroken.close_square,
//               size: 30,
//             ),
//           ),