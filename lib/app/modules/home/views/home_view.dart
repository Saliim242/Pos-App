import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pos_manangement_app/app/modules/home/components/drawer.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';
import '../../../../constants/constants.dart';
import '../../carts/controllers/carts_controller.dart';
import '../../carts/views/carts_view.dart';
import '../../products/components/add_new_products.dart';
import 'package:badges/badges.dart' as badges;
import '../components/app_bar.dart';
import '../components/product_home_grid_view.dart';
import '../components/product_home_list_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final ctr = Get.put(ProductsController());
  late AnimationController rotationController;
  late AnimationController productController;
  final ScrollController scroller = ScrollController();

  @override
  void initState() {
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    productController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    super.initState();

    scroller.addListener(() {
      if (scroller.position.pixels == scroller.position.maxScrollExtent) {
        log("Hello Boss");
      }
    });
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<HomeController>(
      builder: (cont) {
        return ZoomDrawer(
          controller: cont.zoomDrawerController,
          mainScreenScale: 0.23,
          borderRadius: 24.0,
          angle: 0.0,
          mainScreenAbsorbPointer: false,
          androidCloseOnBackTap: true,
          showShadow: true,
          menuBackgroundColor: Get.isDarkMode
              ? Theme.of(context).cardColor
              : AppColor.kJtechPrimaryColor,
          menuScreen: DrawerView(),
          mainScreen: Scaffold(
            appBar: CustomAppBarWidget(cont, rotationController),
            body: GetBuilder<ProductsController>(
              builder: (prod) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor.withOpacity(0.5)
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.3),
                              ),
                              bottom: BorderSide(
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor.withOpacity(0.5)
                                    : AppColor.kJtechPrimaryColor
                                        .withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: cont.isSerachbleOrDropDown
                                      ? TextFormField(
                                          controller:
                                              cont.seartProductController,
                                          onChanged: (value) =>
                                              prod.filterProducts(value),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Get.isDarkMode
                                                ? AppColor.kbgColor
                                                    .withOpacity(0.6)
                                                : AppColor.kJtechPrimaryColor
                                                    .withOpacity(0.6),
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Search Any Product...",
                                            hintStyle: TextStyle(
                                              fontSize: 13,
                                              color: Get.isDarkMode
                                                  ? AppColor.kbgColor
                                                      .withOpacity(0.6)
                                                  : AppColor.kJtechPrimaryColor
                                                      .withOpacity(0.6),
                                            ),
                                          ),
                                        )
                                      : prod.CategoryDropDown(context, prod),
                                ),
                                Container(
                                  height: 60,
                                  width: 1,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor.withOpacity(0.5)
                                      : AppColor.kJtechPrimaryColor
                                          .withOpacity(0.3),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03),
                                GestureDetector(
                                  onTap: () => cont.updateSearchOrCategories(),
                                  child: Icon(
                                    IconlyBroken.search,
                                    size: 26,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor.withOpacity(0.8)
                                        : AppColor.kJtechPrimaryColor
                                            .withOpacity(0.7),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                Container(
                                  height: 60,
                                  width: 1,
                                  color: Get.isDarkMode
                                      ? AppColor.kbgColor.withOpacity(0.5)
                                      : AppColor.kJtechPrimaryColor
                                          .withOpacity(0.3),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03),
                                GetBuilder<CartsController>(builder: (crt) {
                                  return GestureDetector(
                                    onTap: () => crt.changeStudentType(
                                        studentController: productController),
                                    child: RotationTransition(
                                      turns: Tween(begin: 0.0, end: 1.0)
                                          .animate(productController),
                                      child: crt.isGrid.read('getProductType')
                                          ? Icon(
                                              Icons.splitscreen_rounded,
                                              size: 26,
                                              color: Get.isDarkMode
                                                  ? AppColor.kbgColor
                                                      .withOpacity(0.8)
                                                  : AppColor.kJtechPrimaryColor
                                                      .withOpacity(0.7),
                                            )
                                          : Icon(
                                              Icons.grid_view_rounded,
                                              size: 26,
                                              color: Get.isDarkMode
                                                  ? AppColor.kbgColor
                                                      .withOpacity(0.8)
                                                  : AppColor.kJtechPrimaryColor
                                                      .withOpacity(0.7),
                                            ),
                                    ),
                                  );
                                }),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                              ],
                            ),
                          ),
                        ),
                        // All Our Product Will Here
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GetBuilder<CartsController>(builder: (crt) {
                                return crt.isGrid.read('getProductType')
                                    ? ProductHomeListViewWidget()
                                    : ProductHomeGridViewWidget();
                              })
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      child: GetBuilder<CartsController>(builder: (ctrl) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => AddNewProducts(),
                                  fullscreenDialog: true,
                                  transition: Transition.downToUp,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? AppColor.kSecondDarkColor
                                      : AppColor.kJtechSecondColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Iconsax.add_circle,
                                  size: 30,
                                  color: AppColor.kbgColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: ctrl.cartLength != 0
                                  ? () {
                                      Get.to(
                                        () => CartsView(),
                                        fullscreenDialog: true,
                                        transition: Transition.downToUp,
                                      );
                                    }
                                  : () {
                                      ctrl.showToast(
                                          "Please add items to your cart before proceeding to checkout.");
                                    },
                              child:
                                  GetBuilder<CartsController>(builder: (crt) {
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  // width: 60,
                                  //height: 60,
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? AppColor.kSecondDarkColor
                                        : AppColor.kJtechPrimaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      badges.Badge(
                                        showBadge:
                                            crt.cartLength == 0 ? false : true,
                                        badgeContent: Text(
                                          "${crt.cartLength}",
                                          style: TextStyle(
                                            color: AppColor.kbgColor,
                                          ),
                                        ),
                                        position: badges.BadgePosition.topEnd(
                                            top: -10, end: -3),
                                        badgeStyle: badges.BadgeStyle(
                                          badgeColor:
                                              AppColor.kJtechSecondColor,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 13),
                                          child: Icon(
                                            IconlyBroken.buy,
                                            color: AppColor.kbgColor,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      // Icon(
                                      //   IconlyBroken.buy,
                                      //   color: AppColor.kbgColor,
                                      //   size: 26,
                                      // ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Items",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppColor.kbgColor,
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        //crt.totalPrice
                                        "${moneyFormater(crt.box2.hasData(crt.calculatingPrice) ? crt.box2.read(crt.calculatingPrice) : 0).compactSymbolOnLeft}",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: AppColor.kbgColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kSecondDarkColor
                                    : AppColor.kJtechSecondColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                IconlyBroken.scan,
                                color: AppColor.kbgColor,
                                size: 30,
                              ),
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
