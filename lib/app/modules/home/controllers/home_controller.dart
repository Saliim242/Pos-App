import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:pos_manangement_app/app/data/product_model.dart';

class HomeController extends GetxController {
  int currentIndex = 0;
  List<ProductModel> products = [];
  List<ProductModel> foundProductsList = [];
  List<String> categories = [];

  bool isSerachbleOrDropDown = false;
  // Update Buttom navigation Index
  void increment(int index) {
    currentIndex = index;
    update();
  }

  int currentImage = 0;
  void updateImage(int index) {
    currentImage = index;
    update();

    log("Current Image Index Is :${currentImage}",
        name: "UpdateCurent Image Index");
  }

  //Product Drop Down Data
  final TextEditingController seartProductController = TextEditingController();
  final TextEditingController searchCategoryItem = TextEditingController();

  // Update Search Bar Or Categories Drop Down
  void updateSearchOrCategories() {
    isSerachbleOrDropDown = !isSerachbleOrDropDown;
    update();
    log("Now is Search TextFeild Or Categories ${isSerachbleOrDropDown}");
  }

  // Zoom Drawer
  bool get isDrawerOpen => zoomDrawerController.isOpen!();
  final zoomDrawerController = ZoomDrawerController();

  toggleDrawer({required AnimationController rotationController}) async {
    await zoomDrawerController.toggle!();

    if (isDrawerOpen) {
      animateForward(true, rotationController: rotationController);
    } else {
      animateForward(false, rotationController: rotationController);
    }
  }

  void animateForward(bool animate,
      {required AnimationController rotationController}) {
    if (animate) {
      rotationController.forward(from: 0.0);
      update();
    } else {
      rotationController.reverse();
      update();
    }
  }

  void toggleDrawerr() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
