import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/constants.dart';

class CustomEmplyScreen extends StatelessWidget {
  const CustomEmplyScreen({
    super.key,
    required this.img,
    required this.content,
  });

  final String img, content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          LottieBuilder.asset(
            "${img}",
            animate: true,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            alignment: Alignment.center,
          ),
          SizedBox(height: 20),
          Text(
            "${content}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode
                  ? AppColor.kbgColor
                  : AppColor.kJtechPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
