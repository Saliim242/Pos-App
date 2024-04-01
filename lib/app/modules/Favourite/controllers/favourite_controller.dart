import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_manangement_app/app/data/product_model.dart';

class FavouriteController extends GetxController {
  final box = GetStorage();
  final String kFavoriteProducts = 'products';
  final List<ProductModel> favoriteProducts = [];
  int get length => favoriteProducts.length;
  bool checkCourseInFavorite(ProductModel pro) {
    bool isLiked = false;
    for (ProductModel item in favoriteProducts) {
      if (item.id == pro.id) {
        isLiked = true;
      }
    }
    return isLiked;
  }

  Future<void> getFavoriteProducts() async {
    if (box.hasData(kFavoriteProducts)) {
      var data = await box.read(kFavoriteProducts);

      for (var v in data) {
        favoriteProducts.add(
          ProductModel.fromJson(Map<String, dynamic>.from(v)),
        );
      }
      update();
    }
  }

  Future<void> removeFavoriteCourse(ProductModel pro) async {
    favoriteProducts.removeWhere((e) => e.id == pro.id);
    update();
    final products = favoriteProducts.map((v) => v.toJson()).toList();
    await box.remove(kFavoriteProducts);
    await box.write(kFavoriteProducts, products);
  }

  Future<void> emptyFavoriteCourse() async {
    // favoriteProducts.remove((e) => e.id == pro.id);
    // update();
    //favoriteProducts = [];
    update(); //favoriteProducts.map((v) => v.toJson()).toList();
    await box.remove(kFavoriteProducts);
    //await box.write(kFavoriteProducts, products);
  }

  Future<void> saveFavoriteCourse(ProductModel pro) async {
    favoriteProducts.add(pro);
    update();
    final products = favoriteProducts.map((v) => v.toJson()).toList();
    await box.write(kFavoriteProducts, products);
  }

  /// ############################## MAIN ################################### ///
  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }
}
