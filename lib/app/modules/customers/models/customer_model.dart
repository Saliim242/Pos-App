// ignore_for_file: public_member_api_docs, sort_constructors_first

class CustomerModel {
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String customerAddress;
  final bool customerStatus;
  final String customerGender;
  double credit;
  final String suttlementDays;
  final String gaurantorName;
  final String gaurantorPhone;

  CustomerModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerAddress,
    required this.customerStatus,
    required this.customerGender,
    required this.credit,
    required this.suttlementDays,
    required this.gaurantorName,
    required this.gaurantorPhone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'customerAddress': customerAddress,
      'customerStatus': customerStatus,
      'customerGender': customerGender,
      'credit': credit,
      'suttlementDays': suttlementDays,
      'gaurantorName': gaurantorName,
      'gaurantorPhone': gaurantorPhone,
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> map) {
    return CustomerModel(
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      customerEmail: map['customerEmail'],
      customerAddress: map['customerAddress'],
      customerStatus: map['customerStatus'],
      customerGender: map['customerGender'],
      credit: double.parse(map['credit'].toString()),
      suttlementDays: map['suttlementDays'],
      gaurantorName: map['gaurantorName'],
      gaurantorPhone: map['gaurantorPhone'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CustomerModel.fromJson(String source) =>
  //     CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
