// // import 'package:pos_manangement_app/app/data/product_model.dart';

// // class TransactionModel {
// //   final String customerName;
// //   final String cashierName;
// //   final DateTime date;
// //   final String paymentMethodType;
// //   final List<ProductModel> product;
// //   final double billing;

// //   TransactionModel({
// //     required this.customerName,
// //     required this.cashierName,
// //     required this.date,
// //     required this.paymentMethodType,
// //     required this.product,
// //     required this.billing,
// //   });
// // }

// // // var transactions = [
// // //   TransactionModel(
// // //     billing = 45.0,
// // //     cashierName = "Salim Abukar Ahmed",
// // //     customerName = "Anisa Salim",
// // //     date = DateTime.now(),
// // //     paymentMethodType = "cash",
// // //     productPaid = "Iphone",
// // //   ),
// // //   TransactionModel(
// // //     billing = 45.0,
// // //     cashierName = "Salim Abukar Ahmed",
// // //     customerName = "Anisa Salim",
// // //     date = DateTime.now(),
// // //     paymentMethodType = "credit",
// // //     productPaid = "Iphone",
// // //   )
// // // ];

// class TransactionModel {
//   int? tranId;
//   String? customerName;
//   String? cashierName;
//   String? paymentMethod;
//   String? productType;
//   String? items;
//   String? transactionType;

//   TransactionModel({
//     this.tranId,
//     this.customerName,
//     this.cashierName,
//     this.paymentMethod,
//     this.productType,
//     this.items,
//     this.transactionType,
//   });

//   TransactionModel.fromJson(Map<String, dynamic> json) {
//     tranId = json['tranId'];
//     customerName = json['customerName'];
//     cashierName = json['cashierName'];
//     paymentMethod = json['paymentMethod'];
//     productType = json['productType'];
//     items = json['items'];
//     transactionType = json['transactionType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tranId'] = this.tranId;
//     data['customerName'] = this.customerName;
//     data['cashierName'] = this.cashierName;
//     data['paymentMethod'] = this.paymentMethod;
//     data['productType'] = this.productType;
//     data['items'] = this.items;
//     data['transactionType'] = this.transactionType;
//     return data;
//   }
// }
