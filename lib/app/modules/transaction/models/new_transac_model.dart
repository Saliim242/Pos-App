class TransactionModel {
  int? transactionId;
  String? transactionDate;
  String? transactionTime;
  Customer? customer;
  List<Products>? products;
  Billing? billing;
  String? paymentMethod;
  String? status;
  double? refundAmount;
  String? refundReason;
  String? notes;
  String? cashierName;
  double? totalAmount;

  TransactionModel({
    this.transactionId,
    this.transactionDate,
    this.transactionTime,
    this.customer,
    this.products,
    this.billing,
    this.paymentMethod,
    this.status,
    this.refundAmount,
    this.refundReason,
    this.notes,
    this.totalAmount,
    this.cashierName,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    transactionDate = json['transactionDate'];
    transactionTime = json['transactionTime'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    billing =
        json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    refundAmount = double.parse(json['refundAmount'].toString());
    refundReason = json['refundReason'];
    notes = json['notes'];
    cashierName = json['cashierName'];
    totalAmount = double.parse(json['totalAmount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['transactionDate'] = this.transactionDate;
    data['transactionTime'] = this.transactionTime;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['refundAmount'] = this.refundAmount;
    data['refundReason'] = this.refundReason;
    data['notes'] = this.notes;
    data['cashierName'] = this.cashierName;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class Customer {
  int? customerId;
  String? customerName;
  String? email;
  String? address;

  Customer({this.customerId, this.customerName, this.email, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  int? quantity;
  double? price;
  double? totalPerProduct;

  Products(
      {this.productId,
      this.productName,
      this.quantity,
      this.price,
      this.totalPerProduct});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = double.parse(json['price'].toString());
    totalPerProduct = double.parse(json['totalPerProduct'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['totalPerProduct'] = this.totalPerProduct;
    return data;
  }
}

class Billing {
  double? subtotal;
  double? discount;
  // double? total;

  Billing({this.subtotal, this.discount});

  Billing.fromJson(Map<String, dynamic> json) {
    subtotal = double.parse(json['subtotal'].toString());
    discount = double.parse(json['discount'].toString());
    //  total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    // data['total'] = this.total;
    return data;
  }
}
