import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';

import '../../../../constants/constants.dart';
import '../../carts/views/payment_method_as_credit_page.dart';

class AddNewCategoryPage extends StatelessWidget {
  const AddNewCategoryPage({super.key});

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
            'Add New Category',
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
      body: GetBuilder<ProductsController>(builder: (cetegoy) {
        return Form(
          key: cetegoy.categoryformKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SearchbleTextFeilds(
                      icon: Iconsax.category,
                      text: "Search or Add new category",
                      controller: cetegoy.addNewCategoryItem,
                      onChanged: (value) => cetegoy.fillterCategoryLists(value),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "All Categories",
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode
                            ? AppColor.kbgColor
                            : AppColor.kJtechPrimaryColor,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ListView.builder(
                      itemCount: cetegoy.foundCategoriesList
                          .length, // cetegoy.categories.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Theme.of(context).cardColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              Get.isDarkMode
                                  ? BoxShadow()
                                  : BoxShadow(
                                      color: Colors.grey.shade400,
                                      offset: Offset(1, 1),
                                      blurRadius: 1,
                                    )
                            ],
                          ),
                          child: ListTile(
                            tileColor: Colors.transparent,
                            title: Text(
                              "${cetegoy.foundCategoriesList[index]}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechPrimaryColor,
                              ),
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColor.kSecondDarkColor
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                IconlyBroken.category,
                                color: Get.isDarkMode
                                    ? AppColor.kbgColor
                                    : AppColor.kJtechSecondColor,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SignInBtn(
                        text: "Add Category",
                        onPressed: () => cetegoy.addCategory(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
