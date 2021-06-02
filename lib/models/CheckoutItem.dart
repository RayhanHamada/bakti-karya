class CheckoutItem {
  CheckoutItem({
    required this.itemId,
    required this.amount,
  });

  factory CheckoutItem.fromJSON(Map<String, dynamic> map) =>
      CheckoutItem(itemId: map['item_id'], amount: map['amount']);

  String itemId;
  int amount;
}
