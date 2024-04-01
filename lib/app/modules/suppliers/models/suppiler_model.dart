// class SupplierModel {
//   int? id;
//   String? companyName;
//   String? description;
//   String? contentPerson;
//   int? tellephoneOne;
//   int? tellephoneTwo;
//   String? campanyAddress;
//   String? contactEmail;
//   String? thumbnail;

//   SupplierModel({
//     this.id,
//     this.companyName,
//     this.description,
//     this.contentPerson,
//     this.tellephoneOne,
//     this.tellephoneTwo,
//     this.campanyAddress,
//     this.contactEmail,
//     this.thumbnail,
//   });

//   SupplierModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     companyName = json['companyName'];
//     description = json['description'];
//     contentPerson = json['contentPerson'];
//     tellephoneOne = json['tellephoneOne'];
//     tellephoneTwo = json['tellephoneTwo'];
//     campanyAddress = json['campanyAddress'];
//     contactEmail = json['contactEmail'];
//     thumbnail = json['thumbnail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['companyName'] = this.companyName;
//     data['description'] = this.description;
//     data['contentPerson'] = this.contentPerson;
//     data['tellephoneOne'] = this.tellephoneOne;
//     data['tellephoneTwo'] = this.tellephoneTwo;
//     data['campanyAddress'] = this.campanyAddress;
//     data['contactEmail'] = this.contactEmail;
//     data['thumbnail'] = this.thumbnail;
//     return data;
//   }
// }

class SupplierModel {
  int? id;
  String? companyName;
  String? description;
  String? contentPerson;
  int? tellephoneOne;
  int? tellephoneTwo;
  String? campanyAddress;
  String? contactEmail;
  bool? isNetwork;
  String? thumbnail;

  SupplierModel(
      {this.id,
      this.companyName,
      this.description,
      this.contentPerson,
      this.tellephoneOne,
      this.tellephoneTwo,
      this.campanyAddress,
      this.contactEmail,
      this.isNetwork,
      this.thumbnail});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    description = json['description'];
    contentPerson = json['contentPerson'];
    tellephoneOne = json['tellephoneOne'];
    tellephoneTwo = json['tellephoneTwo'];
    campanyAddress = json['campanyAddress'];
    contactEmail = json['contactEmail'];
    isNetwork = json['isNetwork'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['description'] = this.description;
    data['contentPerson'] = this.contentPerson;
    data['tellephoneOne'] = this.tellephoneOne;
    data['tellephoneTwo'] = this.tellephoneTwo;
    data['campanyAddress'] = this.campanyAddress;
    data['contactEmail'] = this.contactEmail;
    data['isNetwork'] = this.isNetwork;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
