import 'package:get/get.dart';
import 'package:pos_manangement_app/app/modules/account%20summary/controllers/account_summary_controller.dart';
import 'package:pos_manangement_app/app/modules/customers/controllers/customers_controller.dart';
import 'package:pos_manangement_app/app/modules/login/controllers/login_controller.dart';
import 'package:pos_manangement_app/app/modules/suppliers/controllers/suppliers_controller.dart';
import 'package:pos_manangement_app/app/modules/transaction/controllers/transaction_controller.dart';

import '../../Favourite/controllers/favourite_controller.dart';
import '../../carts/controllers/carts_controller.dart';
import '../../products/controllers/products_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );

    Get.put(LoginController(), permanent: true);
    Get.put(CustomersController(), permanent: true);
    Get.put(SuppliersController(), permanent: true);
    Get.put(CustomersController(), permanent: true);
    Get.put(FavouriteController(), permanent: true);
    Get.put(ProductsController(), permanent: true);
    Get.put(CartsController(), permanent: true);
    Get.put(AccountSummaryController(), permanent: true);
    Get.put(TransactionController(), permanent: true);
  }
}
