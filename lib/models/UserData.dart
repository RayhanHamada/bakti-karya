import 'package:bakti_karya/models/CheckoutItem.dart';

/// model data untuk collection [users] di firestore
class UserData {
  UserData({
    this.id,
    required this.email,
    required this.name,
    required this.noHp,
    required this.alamat,
  });

  factory UserData.fromJSON(Map<String, dynamic> map) => UserData(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        noHp: map['no_hp'],
        alamat: map['alamat'],
      )..checkoutItems = (map['current_checkout_items'] as List<dynamic>)
          .map((e) => CheckoutItem.fromJSON(e))
          .toList();

  String? id;
  final String email;
  String name;
  String noHp;
  String alamat;
  List<CheckoutItem> checkoutItems = [];

  Map<String, dynamic> toJSON() {
    return {
      'email': this.email,
      'name': this.name,
      'no_hp': this.noHp,
      'alamat': this.alamat,
      'current_checkout_items': checkoutItems,
    };
  }

  /// untuk bikin data awal user di firestore
  Map<String, dynamic> forCreateToFirestore() {
    return {
      'email': this.email,
      'name': this.name,
      'no_hp': this.noHp,
      'alamat': this.alamat,
      'current_checkout_items': [],
    };
  }
}
