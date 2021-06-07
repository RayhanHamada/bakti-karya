import 'package:bakti_karya/models/Product.dart';

/// model data untuk checkout item yang data lengkapnya sudah diambil
class CurrentCheckoutItemData {
  CurrentCheckoutItemData({
    required this.product,
    required this.amount,
  });

  final Product product;
  String photoDownloadURL = '';
  int amount;
}
