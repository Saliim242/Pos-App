import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:pos_manangement_app/app/modules/login/widgets/signin_widget.dart';
import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/custom_line_clip_path.dart';
import '../models/new_transac_model.dart';

class RefundScreenPage extends StatefulWidget {
  const RefundScreenPage({super.key, required this.tras});

  final TransactionModel tras;

  @override
  State<RefundScreenPage> createState() => _RefundScreenPageState();
}

class _RefundScreenPageState extends State<RefundScreenPage> {
  final cont = Get.find<TransactionController>();
  @override
  void initState() {
    super.initState();
    // Initialize selectedProducts with the same length as widget.tras.products
    cont.selectedProducts =
        List.generate(widget.tras.products!.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0.5 : 0.5,
        backgroundColor: //Theme.of(Get.context!).primaryColor,
            Get.isDarkMode
                ? Theme.of(Get.context!).cardColor
                : Colors.grey.shade100,
        centerTitle: true,
        title: Marquee(
          child: Text(
            'Refund Transaction',
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
            color: Get.isDarkMode
                ? AppColor.kbgColor
                : AppColor.kJtechPrimaryColor,
          ),
        ),
      ),
      body: GetBuilder<TransactionController>(
        builder: (ref) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Color(0xff2D3250)
                          : Color(0xffEAF4FE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Refund",
                          style: TextStyle(
                            fontSize: 15,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                        ),
                        Text(
                          "${ref.calculateSelectedTotal(widget.tras)}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Get.isDarkMode
                                ? AppColor.kbgColor
                                : AppColor.kTexMoneyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ClipPath(
                    clipper: CouponClipper(
                      direction: Directionality.of(context),
                      curvePosition: MediaQuery.of(context).size.height * 0.07,
                      curveRadius: 40,
                      curveAxis: Axis.horizontal,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode ? Color(0xff2D3250) : Colors.white,
                      ),
                      child: Column(
                        children: [
                          // Transaction Refunded
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.receipt_1,
                                    color: Get.isDarkMode
                                        ? AppColor.kbgColor
                                        : AppColor.kTexMoneyColor,
                                    size: 25,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    "Items",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Get.isDarkMode
                                          ? AppColor.kbgColor
                                          : AppColor.kTexMoneyColor,
                                    ),
                                  )
                                ],
                              ),
                              widget.tras.refundAmount! > 0
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: widget.tras.status ==
                                                "Partially Refunded"
                                            ? Color(0XFFFEF5E4)
                                            : Color(0XFFFBEBEC),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        "${widget.tras.status}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.isDarkMode
                                              ? AppColor.kbgColor
                                              : widget.tras.status ==
                                                      "Partially Refunded"
                                                  ? Color(0xffEAA029)
                                                  : Color(0xffcb374b),
                                        ),
                                      ),
                                    )
                                  : Text(""),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.037),
                          MySeparator(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.045),

                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: ref.selectAll,
                                      onChanged: (bool? value) =>
                                          ref.selectAllF(value, widget.tras),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Select All",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Get.isDarkMode
                                          ? AppColor.kbgColor
                                          : AppColor.kJtechPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "All Products --> ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.isDarkMode
                                          ? AppColor.kbgColor.withOpacity(0.65)
                                          : AppColor.kJtechPrimaryColor
                                              .withOpacity(0.65),
                                    ),
                                  ),
                                  Text(
                                    "${widget.tras.products!.length} products",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Get.isDarkMode
                                          ? AppColor.kbgColor.withOpacity(0.65)
                                          : AppColor.kJtechPrimaryColor
                                              .withOpacity(0.65),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),

                          // Displaying Products That Was Paid

                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.tras.products!.length,
                            itemBuilder: (context, index) {
                              final double dis =
                                  widget.tras.products![index].price! -
                                      widget.tras.billing!.discount!;
                              return Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: RefundedProductsWidget(
                                  onChanged: (valu) =>
                                      ref.updateNewValue(valu!, index),

                                  //ref.selectedProducts[index] = valu!,
                                  value: ref.selectedProducts[index],
                                  //{widget.tras.products![index].price}
                                  howmanyItems:
                                      "${widget.tras.products![index].quantity} x ${dis}",
                                  productName:
                                      "${widget.tras.products![index].productName}",
                                ),
                              );
                            },
                          ),

                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<TransactionController>(builder: (ref) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: SizedBox(
              child: SignInBtn(
                text: "Refunded ${ref.calculateSelectedTotal(widget.tras)}",
                onPressed: () {},
              ),
            ),
          ),
        );
      }),
    );
  }
}

class RefundedProductsWidget extends StatelessWidget {
  const RefundedProductsWidget({
    super.key,
    required this.productName,
    required this.howmanyItems,
    this.onChanged,
    this.value,
    //required this.money,
  });

  final String productName;
  final String howmanyItems;
  final void Function(bool?)? onChanged;
  final bool? value;
  //final double money;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${productName}",
                style: TextStyle(
                  fontSize: 15,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor
                      : AppColor.kJtechPrimaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${howmanyItems}",
                style: TextStyle(
                  fontSize: 12,
                  color: Get.isDarkMode
                      ? AppColor.kbgColor.withOpacity(0.65)
                      : AppColor.kJtechPrimaryColor.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




        // Expanded(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: Colors.red,
        //         ),
        //         child: Icon(Iconsax.minus_square),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         child: Text("0"),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(8),
        //         color: Colors.red,
        //         child: Icon(Iconsax.add_square),
        //       )
        //     ],
        //   ),
        // ),