import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:pos_manangement_app/app/modules/Favourite/views/favourite_view.dart';
import 'package:pos_manangement_app/app/modules/account%20summary/views/account_summary_view.dart';
import 'package:pos_manangement_app/app/modules/home/controllers/home_controller.dart';
import 'package:pos_manangement_app/app/modules/login/views/login_view.dart';
import 'package:pos_manangement_app/app/modules/login/views/settings/setting_scren_view.dart';
import 'package:pos_manangement_app/app/modules/products/views/products_view.dart';
import 'package:pos_manangement_app/app/modules/suppliers/views/suppliers_view.dart';
import 'package:pos_manangement_app/app/modules/transaction/views/transaction_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants.dart';
import '../../customers/views/customers_view.dart';
import '../../reports/views/reports_view.dart';
import 'reusable_list_tile.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    //bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Theme.of(context).cardColor
          : AppColor.kJtechPrimaryColor,
      body: GetBuilder<HomeController>(
        builder: (dr) {
          return ListView(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor.withOpacity(
                                  0.6) // AppColor.kThirdDarkColor.withOpacity(0.6)
                              : AppColor.kbgColor,
                          width: 3.5,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image:

                        //   // NetworkImage(
                        //   //   "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png",
                        //   // ),
                        //   //"assets/images/zalim.jpg"
                        // ),
                        boxShadow: [
                          Get.isDarkMode
                              ? BoxShadow()
                              : BoxShadow(
                                  color: Get.isDarkMode
                                      ? Theme.of(context).cardColor
                                      : Colors.grey.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(
                                    0,
                                    -4,
                                  ), // changes position of shadow
                                ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png",
                        width: 110,
                        height: 110,
                        placeholder: (context, url) => Container(
                          //height: 100.0,
                          //margin: const EdgeInsets.all(12),
                          //margin: EdgeInsets.only(bottom: 12),

                          child: Shimmer.fromColors(
                            baseColor: Get.isDarkMode
                                ? Color(0xff3f3f3f)
                                : Colors.grey[300]!,
                            highlightColor: Get.isDarkMode
                                ? Colors.white10
                                : Colors.grey[100]!,
                            child: Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Salim Abukar Ahmed",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Metrophobic",
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode
                          ? Color(0xffe5e5e5)
                          : Color(0xffd6d6d6), //AppColor.kSchoolPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Bussiness Name",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Metrophobic",
                      fontWeight: FontWeight.w500,
                      color: Get.isDarkMode
                          ? Color(0xffe5e5e5)
                          : Color(0xffd6d6d6), //AppColor.kSchoolPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Get.isDarkMode
                          ? AppColor.kbgColor
                          : AppColor.kbgColor,
                      thickness: 1.0,
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ReusableDrawerMenu(
                    child: const TransactionView(),
                    text: "Trasactions",
                    icon: IconlyBroken.filter_2,
                  ),
                  ReusableDrawerMenu(
                    child: const AccountSummaryView(),
                    text: "Account Summery",
                    icon: IconlyBroken.info_square,
                  ),
                  ReusableDrawerMenu(
                    child: ProductsView(),
                    text: "Inventory",
                    icon: IconlyBroken.graph,
                  ),
                  // ReusableDrawerMenu(
                  //   child: const SizedBox(),
                  //   text: "Expense & Income".tr,
                  //   icon: IconlyBroken.wallet,
                  // ),
                  ReusableDrawerMenu(
                    child: const CustomersView(),
                    text: "Customers",
                    icon: IconlyBroken.user_3,
                  ),
                  ReusableDrawerMenu(
                    child: const SuppliersView(),
                    text: "Suppliers".tr,
                    icon: IconlyBroken.scan,
                  ),
                  ReusableDrawerMenu(
                    child: const FavouriteView(),
                    text: "favourite".tr,
                    icon: IconlyBroken.profile,
                  ),
                  ReusableDrawerMenu(
                    child: ReportsView(),
                    text: "Reports".tr,
                    icon: IconlyBroken.chart,
                  ),
                  ReusableDrawerMenu(
                    child: SettingScreenView(),
                    text: "Settings".tr,
                    icon: IconlyBroken.setting,
                  ),
                  ReusableDrawerMenu(
                    child: LoginView(),
                    text: "SignOut".tr,
                    icon: IconlyBroken.logout,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// Scaffold(
//           backgroundColor = Get.isDarkMode
//               ? Theme.of(context).cardColor
//               : AppColor.kSchoolPrimaryColor, //Color(0xffd6d6d6),
//           body = Consumer2<UserProvider, ThemeNotifier>(
//             builder: (context, value, notifcationValue, _) => SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 16 * 2,
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Container(
//                         margin: EdgeInsets.only(top: 20),
//                         width: 110,
//                         height: 110,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Get.isDarkMode
//                                 ? Theme.of(context).cardColor.withOpacity(
//                                     0.6) // AppColor.kThirdDarkColor.withOpacity(0.6)
//                                 : AppColor.kbgColor,
//                             width: 3.5,
//                           ),
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(10),
//                             topLeft: Radius.circular(10),
//                             bottomRight: Radius.circular(15),
//                             bottomLeft: Radius.circular(15),
//                           ),
//                           image: DecorationImage(
//                             fit: BoxFit.cover,
//                             image: CachedNetworkImageProvider(
//                               value.currentStudentUser?.image ??
//                                   "https://www.pngmart.com/files/22/User-Avatar-Profile-PNG-Isolated-Transparent-Picture.png",
//                             ),
//                             //"assets/images/zalim.jpg"
//                           ),
//                           boxShadow: [
//                             Get.isDarkMode
//                                 ? BoxShadow()
//                                 : BoxShadow(
//                                     color: Get.isDarkMode
//                                         ? Theme.of(context).cardColor
//                                         : Colors.grey.withOpacity(0.2),
//                                     blurRadius: 15,
//                                     offset: const Offset(
//                                       0,
//                                       -4,
//                                     ), // changes position of shadow
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.015),
//                     Text(
//                       "${value.currentStudentUser?.name ?? ""}",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontFamily: "Metrophobic",
//                         fontWeight: FontWeight.w500,
//                         color: Get.isDarkMode
//                             ? Color(0xffe5e5e5)
//                             : Color(0xffd6d6d6), //AppColor.kSchoolPrimaryColor,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Divider(
//                         color: Get.isDarkMode
//                             ? AppColor.kbgColor
//                             : AppColor.kThirdDarkColor,
//                         thickness: 1.0,
//                       ),
//                     ),
//                     // ListTile(
//                     //   onTap: () => DailySchedule(), //value.toggleDrawerr(),
//                     //   leading: Icon(
//                     //     IconlyBroken.home,
//                     //     color:
//                     //         Get.isDarkMode ? Color(0xffe5e5e5) : Color(0xffd6d6d6),
//                     //     size: 22,
//                     //   ),
//                     //   title: Text(
//                     //     "Daily Schedule",
//                     //     style: TextStyle(
//                     //       fontSize: 13,
//                     //       color: Get.isDarkMode
//                     //           ? Color(0xffe5e5e5)
//                     //           : Color(0xffd6d6d6),
//                     //     ),
//                     //   ),
//                     // ),

//                     ReusableDrawerMenu(
//                       child: DailySchedule(),
//                       text: "daily_schedule".tr,
//                       icon: IconlyBroken.calendar,
//                     ),

//                     ReusableDrawerMenu(
//                       child: AttendanceScreen(),
//                       text: "attendance".tr,
//                       icon: IconlyBroken.times_quare,
//                     ),
//                     ReusableDrawerMenu(
//                       child: const FinanceScreen(),
//                       text: "finance".tr,
//                       icon: IconlyBroken.wallet,
//                     ),
//                     ReusableDrawerMenu(
//                       child: ExamScreen(),
//                       text: "exams".tr,
//                       icon: IconlyBroken.document,
//                     ),
//                     ReusableDrawerMenu(
//                       child: UserProfile(),
//                       text: "My Profile".tr,
//                       icon: IconlyBroken.profile,
//                     ),
//                     // ReusableDrawerMenu(
//                     //   child: AboutUsScreen(),
//                     //   text: "Welcome".tr,
//                     //   icon: IconlyBroken.message,
//                     // ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Divider(
//                           color: Get.isDarkMode
//                               ? Color(0xffe5e5e5)
//                               : AppColor.kThirdDarkColor,
//                           thickness: 1.0),
//                     ),

//                     ListTile(
//                       onTap: () => Navigator.push(
//                         context,
//                         PageTransition(
//                           child: AboutDevelopers(),
//                           type: PageTransitionType.rightToLeft,
//                         ),
//                       ),
//                       leading: Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Get.isDarkMode
//                               ? AppColor.kSecondaryLightColor.withOpacity(0.6)
//                               : Color(0xff4b338e),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Icon(
//                           IconlyBroken.info_square,
//                           color: Color(0xffe5e5e5),
//                           size: 22,
//                         ),
//                       ),
//                       title: Text(
//                         "About Developer".tr,
//                         style: TextStyle(
//                           fontFamily: "Metrophobic",
//                           fontSize: 14,
//                           color: Get.isDarkMode
//                               ? Color(0xffe5e5e5)
//                               : Color(0xffd6d6d6),
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       onTap: () => {
//                         //value.logOut(kStudentInfo, context)

//                         value.showLogoutConfirmationDialog(
//                           context,
//                           btnOkOnPress: () {
//                             value.logOut(kStudentInfo, context);
//                           },
//                         )
//                       },
//                       leading: Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Get.isDarkMode
//                               ? AppColor.kSecondaryLightColor.withOpacity(0.6)
//                               : Color(0xff4b338e),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Icon(
//                           IconlyBroken.logout,
//                           color: Color(0xffe5e5e5),
//                           size: 22,
//                         ),
//                       ),
//                       title: Text(
//                         "Logout".tr,
//                         style: TextStyle(
//                           fontFamily: "Metrophobic",
//                           fontSize: 14,
//                           color: Get.isDarkMode
//                               ? Color(0xffe5e5e5)
//                               : Color(0xffd6d6d6),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: Center(
//                         child: Text(
//                           textAlign: TextAlign.center,
//                           "${update.latestVersionModel.name}",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: "Metrophobic",
//                             color: Get.isDarkMode
//                                 ? Color(0xffe5e5e5)
//                                 : Color(0xffd6d6d6),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
