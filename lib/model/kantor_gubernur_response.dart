import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class KantorGubenurResponse {
  KantorGubenurResponse({
    this.id,
    this.province,
    this.address,
    this.website,
    this.phone,
    this.email,
    this.image,
  });

  factory KantorGubenurResponse.fromJson(Map<String, dynamic> json) =>
      KantorGubenurResponse(
        id: asT<int?>(json['id']),
        province: asT<String?>(json['province']),
        address: asT<String?>(json['address']),
        website: asT<String?>(json['website']),
        phone: asT<String?>(json['phone']),
        email: asT<String?>(json['email']),
        image: asT<String?>(json['image']),
      );

  int? id;
  String? province;
  String? address;
  String? website;
  String? phone;
  String? email;
  String? image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'province': province,
        'address': address,
        'website': website,
        'phone': phone,
        'email': email,
        'image': image,
      };
}
