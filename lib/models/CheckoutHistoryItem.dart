import 'package:bakti_karya/models/CurrentCheckoutItem.dart';

class CheckoutHistoryItem {
  CheckoutHistoryItem({
    required this.userId,
    required this.time,
    required this.checkoutItems,
  });

  final List<CurrentCheckoutItem> checkoutItems;
  final DateTime time;
  final String userId;

  factory CheckoutHistoryItem.fromJSON(Map<String, dynamic> map) =>
      CheckoutHistoryItem(
        userId: map['user_id'],
        time: DateTime.fromMillisecondsSinceEpoch(map['time']),
        checkoutItems: (map['checkout_items'] as List)
            .map((e) => CurrentCheckoutItem.fromJSON(e))
            .toList(),
      );

  Map<String, dynamic> toJSON() => {
        'user_id': userId,
        'time': time.millisecondsSinceEpoch,
        'checkout_items': checkoutItems.map((e) => e.toJSON()).toList(),
      };
}
