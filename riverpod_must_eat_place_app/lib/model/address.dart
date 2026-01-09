import 'dart:typed_data';

class Address {
  final int? id;
  final String name;
  final String phone;
  final String estimate;
  final double lat;
  final double lng;
  final Uint8List image;

  Address({
    this.id,
    required this.name,
    required this.phone,
    required this.estimate,
    required this.lat,
    required this.lng,
    required this.image,
  });

  // Map => Address로 변환(DB 조회)

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      estimate: map['estimate'] ?? '',
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
      image: map['image'],
    );
  }

  // Address => Map(DB 저장시)

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'estimate': estimate,
      'lat': lat,
      'lng': lng,
      'image': image,
    };
  }
}
