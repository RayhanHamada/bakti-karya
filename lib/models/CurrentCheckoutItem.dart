/// class model untuk field [current_checkout_items] di firestore
class CurrentCheckoutItem {
  CurrentCheckoutItem({
    required this.itemId,
    required this.amount,
  });

  factory CurrentCheckoutItem.fromJSON(Map<String, dynamic> map) =>
      CurrentCheckoutItem(itemId: map['item_id'], amount: map['amount']);

  Map<String, dynamic> toJSON() => {
        'item_id': itemId,
        'amount': amount,
      };

  String itemId;
  int amount;
}
