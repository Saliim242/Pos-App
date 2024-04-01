// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../../constants/constants.dart';
import '../../carts/views/payment_method_as_credit_page.dart';
import '../../components/custom_error_screens.dart';

import '../components/inventory_product_card.dart';
import '../components/invontory_loading.dart';
import '../controllers/products_controller.dart';

class ProductsView extends StatefulWidget {
  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> with AfterLayoutMixin {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    controller
      ..addListener(() {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          log("Salim Abukar Ahmed");
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Theme.of(Get.context!).scaffoldBackgroundColor,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'All Our Inventory',
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
            //IconlyBroken.more_square,
            //color: Get.theme.hoverColor,
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<ProductsController>(
        builder: (addPr) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SearchbleTextFeilds(
                  controller: addPr.inventoryProductSearch,
                  text: "Search You'r Product Here !",
                  icon: Iconsax.search_favorite,
                  onChanged: (query) => addPr.filterProducts(query),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                GetBuilder<ProductsController>(
                  builder: (prs) {
                    if (prs.isLoadingProduct) {
                      return ListView.builder(
                        itemCount: 7,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InventoryLoading();
                        },
                      );
                    } else if (prs.products.isEmpty) {
                      return CustomEmplyScreen(
                        content:
                            "Uh-oh! It appears that your inventory is empty. Time to stock up and fill it with exciting items. Start adding products and let the inventory adventure begin!",
                        img: "assets/animations/empty.json",
                      );
                    }

                    return addPr.foundProductsList.isNotEmpty
                        ? AnimationLimiter(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: prs.foundProductsList.length,
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
                                    child: FocusedMenuHolder(
                                      menuWidth:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                      openWithTap: prs.isOpen,
                                      animateMenuItems: true,
                                      blurBackgroundColor: Colors.black45,
                                      blurSize: 1,
                                      menuItems: <FocusedMenuItem>[
                                        FocusedMenuItem(
                                          backgroundColor:
                                              AppColor.kJtechSecondColor,
                                          title: const Text(
                                            "Remove it",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          trailingIcon: const Icon(
                                              IconlyBroken.delete,
                                              color: Colors.white),
                                          onPressed: () {},
                                        ),
                                      ],
                                      onPressed: () {},
                                      child: InvontryOrProductCard(
                                        pro: prs.foundProductsList[index],
                                      ),
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
                                  " No Invontry found. Explore other options or refine your search for a perfect match",
                            ),
                          );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Get.find<ProductsController>().getProducts();
    throw UnimplementedError();
  }
}



    //  AnimationConfiguration.staggeredList(
    //                           duration: const Duration(milliseconds: 375),
    //                           position: index,
    //                           child: ScaleAnimation(
    //                             delay: const Duration(milliseconds: 200),
    //                             // horizontalOffset: 50,
    //                             // verticalOffset: 50.0,
    //                             child: SlideAnimation(
    //                               delay: const Duration(milliseconds: 300),
    //                               child: FocusedMenuHolder(
    //                                 menuWidth:
    //                                     MediaQuery.of(context).size.width *
    //                                         0.50,
    //                                 openWithTap: true,
    //                                 animateMenuItems: true,
    //                                 blurBackgroundColor: Colors.black45,
    //                                 blurSize: 1,
    //                                 menuItems: <FocusedMenuItem>[
    //                                   FocusedMenuItem(
    //                                     backgroundColor:
    //                                         AppColor.kJtechSecondColor,
    //                                     title: const Text(
    //                                       "Remove it",
    //                                       style: TextStyle(
    //                                           color: Colors.white),
    //                                     ),
    //                                     trailingIcon: const Icon(
    //                                         IconlyBroken.delete,
    //                                         color: Colors.white),
    //                                     onPressed: () {},
    //                                   ),
    //                                 ],
    //                                 onPressed: () {},
    //                                 child: InvontryOrProductCard(
    //                                   pro: prs.foundProductsList[index],
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         )

