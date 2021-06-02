import 'package:bakti_karya/models/CheckoutItem.dart';

class User {
  User({
    required this.email,
    required this.nama,
    required this.noHp,
    required this.alamat,
  });

  final String email;
  String nama;
  String noHp;
  String alamat;

  List<CheckoutItem> checkoutItems = [];
}
