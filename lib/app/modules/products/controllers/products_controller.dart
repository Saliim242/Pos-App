import 'dart:developer';

import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_manangement_app/app/modules/products/providers/product_provider.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/display_message_errors.dart';
import '../../../data/product_model.dart';
import '../../login/widgets/widegts.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController {
  final productformKey = GlobalKey<FormState>();
  final categoryformKey = GlobalKey<FormState>();
  int currentIndex = 0;
  List<ProductModel> products = [];
  List<ProductModel> foundProductsList = [];
  List<String> categories = [];
  List<String> foundCategoriesList = [];
  double profitorloss = 00.00;

  bool isLoadingProduct = false;
  bool isNoInternet = false;
  bool isSerachbleOrDropDown = false;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  // Adding New Product Controllers
  final TextEditingController productName = TextEditingController();
  final TextEditingController productBarCode = TextEditingController();
  final TextEditingController productSellingPrice = TextEditingController();
  final TextEditingController productCostPrice = TextEditingController();
  final TextEditingController inventoryProductSearch = TextEditingController();
  final TextEditingController addNewCategoryItem = TextEditingController();

  // Update Buttom navigation Index
  void increment(int index) {
    currentIndex = index;
    update();
  }

  // Money For matter

  // Update Image Selecting
  bool isThumna = true;
  int currentImage = 0;
  void updateImage(int index) {
    currentImage = index;
    isThumna = false;
    update();
  }

  //Product Drop Down Data
  final TextEditingController seartProductController = TextEditingController();
  final TextEditingController searchCategoryItem = TextEditingController();
  final List<String> items = [
    'Electronics',
    'smartphones',
    'laptops',
    'fragrances',
    'skincare',
    'groceries',
    'home-decoration',
  ];
  String? selectedValue;
  // Update Product Value
  updateStatus(String value) {
    selectedValue = value;
    update();

    log("Current Value is ${selectedValue}");
  }

  // Search Category
  void filterProductAsCategory() {
    foundProductsList = products.where((product) {
      return (selectedValue!.isEmpty || product.category == selectedValue);
    }).toList();

    /*

    &&
            (searchCategoryItem.text.isEmpty ||
                product.title!
                    .toLowerCase()
                    .contains(searchCategoryItem.text.toLowerCase()));

    */
  }

  // Update Search Bar Or Categories Drop Down
  // void updateSearchOrCategories() {
  //   isSerachbleOrDropDown = !isSerachbleOrDropDown;
  //   update();
  //   log("Now is Search TextFeild Or Categories ${isSerachbleOrDropDown}");
  // }

  // Display All Products

  getProducts() async {
    try {
      isLoadingProduct = true;
      update();

      List data = await ProductProvider().getProducts();

      await Future.delayed(Duration(seconds: 2));

      products = data.map((e) => ProductModel.fromJson(e)).toList();
      update();

      //products = await HomeProvider().getProducts();
      //products = data.map((e) => null);
    } on SocketException {
      isNoInternet = true;
      update();
      //return true;

      //showMessage(message: "Please, check your Internet Connection!");
    } catch (e) {
      log(e.toString(), name: "Error Ayaa Ka dhacay Reading Products");
    }

    isLoadingProduct = false;
    isNoInternet = false;
    update();
  }

  @override
  void onInit() async {
    await getProducts();
    foundProductsList = products;
    categories.assignAll(
        Set<String>.from(products.map((product) => product.category!)));
    foundCategoriesList = categories;

    log("The Leng is ${foundCategoriesList.length} categories");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    addNewCategoryItem.dispose();
    productName.dispose();
    productBarCode.dispose();
    productCostPrice.dispose();
    productCostPrice.dispose();

    super.onClose();
  }

  // Add New Product To The Database =========
  void addNewProduct() {
    if (productformKey.currentState!.validate() &&
        CategoryStatus != 'Select Category') {
      //Get.back();

      showSnackBars(
        context: Get.context!,
        contentType: ContentType.success,
        title: "Hold on!",
        message: "Added New Product Successfully",
      );

      removeImage();

      productName.clear();
      productBarCode.clear();
      productCostPrice.clear();
      productSellingPrice.clear();
      CategoryStatus = 'Select Category';
    } else {
      CategoryStatus == 'Select Category'
          ? showSnackBars(
              context: Get.context!,
              contentType: ContentType.failure,
              title: "🚀 Select a Category to Begin!",
              message:
                  "Your journey starts by picking a category from the dropdown. Let's tailor your experience together! 🛍️✨",
            )
          : showSnackBars(
              context: Get.context!,
              contentType: ContentType.failure,
              title: "Oops!",
              message:
                  "Don't Forget to Fill in All Fields Before Adding the New Product. Every Detail Counts! 🛍️✨",
            );
    }
  }

  // ======= Ends Adding New Products

  // =======   Adding New Category T The List

  void addCategory() {
    if (categoryformKey.currentState!.validate()) {
      String inputCategory = addNewCategoryItem.text.trim();

      categories.add(inputCategory);
      foundCategoriesList = categories;

      addNewCategoryItem.clear();
      update();

      showSnackBars(
        context: Get.context!,
        contentType: ContentType.success,
        title: "Hold on!",
        message: "Added New Product Successfully",
      );
    } else {
      showSnackBars(
        context: Get.context!,
        contentType: ContentType.failure,
        title: "Oops!",
        message:
            "Don't Forget to Fill in All Fields Before Adding the New Product. Every Detail Counts! 🛍️✨",
      );
    }
  }

  // ======= End Adding New Category T The List

  // calculating profit or loss of the selling product=========
  double calculateProfitLoss() {
    double costPrice = double.tryParse(productCostPrice.text) ?? 0;
    double sellingPrice = double.tryParse(productSellingPrice.text) ?? 0;
    //int quantity = int.tryParse(quantityController.text) ?? 0;

    // double totalCost = costPrice * quantity;
    // double totalSales = sellingPrice * quantity;
    profitorloss = sellingPrice - costPrice;
    update();
    log("Valueehjshdghasgdah $profitorloss");
    return profitorloss;
  }
  //======== Ends===

  // Searchble All Producrs Lists By There nAMESS ====
  void filterProducts(String query) {
    foundProductsList = products
        .where(
          (product) =>
              product.title!.toLowerCase().contains(query.toLowerCase()) ||
              product.category!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();

    update();
  }

  /// ========= Ends
  ///
  ///  Searchble All Categoray Lists By Names

  void fillterCategoryLists(String query) {
    foundCategoriesList = categories
        .where(
            (category) => category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    update();
  }

  //======= Ends Searchble All Categoray Lists By Names

  // List Of Categories
  // //Product Drop Down Data ================
  DropdownButtonHideUnderline CategoryDropDown(
      BuildContext context, ProductsController pro) {
    return DropdownButtonHideUnderline(
      child: pro.categories.isEmpty
          ? Text(
              'No categories found',
              style: TextStyle(
                fontSize: 15,
                color: Get.isDarkMode
                    ? AppColor.kbgColor
                    : AppColor.kJtechPrimaryColor,
              ),
              textAlign: TextAlign.center,
            )
          : DropdownButton2<String>(
              barrierDismissible: true,

              isExpanded: true,
              //barrierColor: Colors.red,

              dropdownStyleData: DropdownStyleData(
                elevation: 0,
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Theme.of(context).cardColor
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              // Search Data
              dropdownSearchData: DropdownSearchData(
                searchController: pro.searchCategoryItem,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextFeilds(
                          hintText: "Search for Categories...",
                          showPassowrd: false,
                          controller: pro.searchCategoryItem,
                          iconData: IconlyBroken.search,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     cont.selectedValue = '';
                      //   },
                      //   icon: Icon(Icons.close),
                      // )
                    ],
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value
                      .toString()
                      .toLowerCase()
                      .contains(searchValue.toLowerCase());

                  // item.value
                  //     .toString()
                  //     .contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  pro.searchCategoryItem.clear();
                }
              },
              hint: Text(
                'All Categories',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),

              items: pro.categories
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          color: Get.isDarkMode
                              ? AppColor.kbgColor
                              : AppColor.kJtechPrimaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: pro.selectedValue,
              onChanged: (String? value) {
                pro.updateStatus(value.toString());
                pro.filterProductAsCategory();
              },

              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              // menuItemStyleData:
              //     const MenuItemStyleData(),
            ),
    );
  }

  // Category List

  String CategoryStatus = "Select Category";
  void updateCategoryStatus(String status) {
    CategoryStatus = status;

    log("User Selects ${status}");
    update();
  }

  //  End of ========== DropDown Menu

  //============================= Prodduct Adding Image and Crop Image Are There===========
  // Product Image Get The User
  final keyValue = 'prImg';
  final box = GetStorage();

  File? imageFile;
  final picker = ImagePicker();
  final box2 = GetStorage();

  imgFromGallery() async {
    // Map<Permission, PermissionStatus> statuses = await [
    //   Permission.storage,
    //   Permission.camera,
    // ].request();

    var status = await Permission.storage.request();

    if (status.isGranted) {
      await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 100)
          .then((value) {
        if (value != null) {
          _cropImage(File(value.path));

          // ImagePicker().pickImage(source: ImageSource.gallery);

          log("Image Path is ${value.path}",
              name: "Choosing Image From The Gallery");
        }
      });
    } else {
      print('no permission provided');
    }
  }

  imgFromCamera() async {
    var cameraPermisition = await Permission.camera.request();

    if (cameraPermisition.isGranted) {
      await picker
          .pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      )
          .then((value) {
        if (value != null) {
          _cropImage(File(value.path));
        }
      });
    }
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      compressQuality: 100,
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: Get.isDarkMode
              ? AppColor.kJtechPrimaryColor
              : AppColor.kJtechSecondColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        )
      ],
    );
    if (croppedFile != null) {
      imageCache.clear();
      imageFile = File(croppedFile.path);
      box2.write("custom", imageFile!.path);
      update();
      // reload();
    }
  }

  // Removing Product Image
  void removeImage() async {
    box2.remove('custom');
    update();
  }

  //============================= End Prodduct Adding Image and Crop Image Are There===========

  // Readig Bar Code Codes
  Future<void> scanBarcode() async {
    try {
      String barcodeScan;
      barcodeScan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "cancle",
        true,
        ScanMode.BARCODE,
      );

      productBarCode.text = barcodeScan;
      update();

      log("Hey Salim it Works Fine Congratuate $barcodeScan",
          name: "Reading Bar code Scanner");
    } on FormatException {
      // Handle a situation where the user cancels the scan (back button pressed)
      print('Scan canceled');
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
    }
  }

  // Future<void> scanBarcode() async {
  //   try {
  //     String barcodeScan;
  //     barcodeScan = await FlutterBarcodeScanner.scanBarcode(
  //       "#ff6666",
  //       "cancle",
  //       true,
  //       ScanMode.BARCODE,
  //     );

  //     log("Hey Salim it Works Fine Congratuate $barcodeScan",
  //         name: "Reading Bar code Scanner");
  //   } on PlatformException catch (e) {
  //     log(e.message.toString());
  //   }
  // }

  bool isOpen = false;

  void updateOpen() {
    isOpen = !isOpen;
    update();
    log(isOpen.toString());
  }
}
