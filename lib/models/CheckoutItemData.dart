import 'package:bakti_karya/models/Product.dart';

/// model data untuk checkout item yang data lengkapnya sudah diambil
class CheckoutItemData {
  CheckoutItemData({
    required this.product,
    required this.amount,
  });

  final Product product;
  String photoDownloadURL = '';
  int amount;
}
