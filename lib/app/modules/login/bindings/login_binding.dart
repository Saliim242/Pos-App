import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/Favourite/controllers/favourite_controller.dart';
import 'package:pos_manangement_app/app/modules/carts/controllers/carts_controller.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import 'package:pos_manangement_app/app/modules/home/controllers/home_controller.dart';
import 'package:pos_manangement_app/app/modules/products/controllers/products_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginController(),
    );

    Get.put(HomeController(), permanent: true);
    Get.put(CustomersController(), permanent: true);
    Get.put(FavouriteController(), permanent: true);
    Get.put(ProductsController(), permanent: true);
    Get.put(CartsController(), permanent: true);
  }
}
