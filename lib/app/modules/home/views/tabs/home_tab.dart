import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (home) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Column(
                  children: [],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
