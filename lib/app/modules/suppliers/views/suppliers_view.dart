import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/components/custom_error_screens.dart';
import 'package:pos_manangement_app/app/modules/suppliers/views/loading_sup_shimmer.dart';
import '../../../../constants/constants.dart';
import '../components/supllier_card.dart';
import '../controllers/suppliers_controller.dart';
import 'add_new_supplier.dart';

class SuppliersView extends StatefulWidget {
  const SuppliersView({Key? key}) : super(key: key);

  @override
  State<SuppliersView> createState() => _SuppliersViewState();
}

class _SuppliersViewState extends State<SuppliersView> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuppliersController>(builder: (sp) {
      return RefreshIndicator(
        onRefresh: () => sp.loadSuppliers(),
        child: Scaffold(
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
                'All Our Suppliers',
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
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => AddNewSupplier());
                },
                icon: Icon(
                  Iconsax.building_4,
                ),
              ),
            ],
          ),
          body: GetBuilder<SuppliersController>(
            builder: (sup) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Company Management & Information",
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    GetBuilder<SuppliersController>(
                      builder: (sp) {
                        if (sp.isSupplierLoading) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sup.suppliers.length,
                            itemBuilder: (context, index) => LoadingSuppliers(),
                          );
                        } else if (sp.suppliers.isEmpty) {
                          return CustomEmplyScreen(
                            img: "assets/animations/empty.json",
                            content:
                                "Oh Sorry No Suppliers Found Please Add Supplies",
                          );
                        }

                        return AnimatedContainer(
                          duration: Duration(milliseconds: 375),
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: sup.suppliers.length,
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
                                    child: SupplierCard(
                                      sup: sup.suppliers[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Get.find<SuppliersController>().loadSuppliers();
    throw UnimplementedError();
  }
}
