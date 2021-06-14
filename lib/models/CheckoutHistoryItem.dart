import 'package:bakti_karya/models/CurrentCheckoutItem.dart';
import 'package:bakti_karya/utils.dart';

enum StatusCheckoutHistoryItem {
  Menunggu_Pembayaran,
  Dikirim,
  Sampai,
}

class CheckoutHistoryItem {
  CheckoutHistoryItem({
    required this.userId,
    required this.time,
    required this.checkoutItems,
    required this.status,
    required this.paymentMethod,
    this.noVirtualAccount,
    this.bank,
  });

  String? id = '';
  final String userId;
  final DateTime time;
  final List<CurrentCheckoutItem> checkoutItems;
  StatusCheckoutHistoryItem status;
  final PaymentMethod paymentMethod;

  /// field tidak null hanya jika [paymentMethod] bernilai VirtualAccount
  String? noVirtualAccount;
  Bank? bank;

  factory CheckoutHistoryItem.fromJSON(Map<String, dynamic> map) =>
      CheckoutHistoryItem(
        userId: map['user_id'],
        time: DateTime.fromMillisecondsSinceEpoch(map['time']),
        checkoutItems: (map['checkout_items'] as List)
            .map((e) => CurrentCheckoutItem.fromJSON(e))
            .toList(),
        status: stringToStatus(map['status']),
        paymentMethod: stringToPaymentMethod(map['payment_method']),
        noVirtualAccount: map['no_vc'],
        bank: stringToBank(map['bank']),
      )..id = map['id'];

  Map<String, dynamic> toJSON() => {
        'user_id': userId,
        'time': time.millisecondsSinceEpoch,
        'checkout_items': checkoutItems.map((e) => e.toJSON()).toList(),
        'status': statusToString(status),
        'payment_method': paymentMethodToString(paymentMethod),
        'no_vc': noVirtualAccount,
        'bank': bankToString(bank),
      };

  static PaymentMethod stringToPaymentMethod(String paymentMethod) {
    var paymentMethodMap =
        PaymentMethod.values.fold<Map<String, PaymentMethod>>(
            {},
            (p, e) => {
                  ...p,
                  e.toString().replaceFirst('PaymentMethod.', ''): e,
                });

    return paymentMethodMap[paymentMethod]!;
  }

  static Bank? stringToBank(String bank) {
    var bankMap = Bank.values.fold<Map<String, Bank>>(
        {},
        (p, e) => {
              ...p,
              e.toString().replaceFirst('Bank.', ''): e,
            });

    return bankMap[bank];
  }

  static StatusCheckoutHistoryItem stringToStatus(String status) {
    var statusMap = StatusCheckoutHistoryItem.values
        .fold<Map<String, StatusCheckoutHistoryItem>>(
            {},
            (p, e) => {
                  ...p,
                  e.toString().replaceFirst('StatusCheckoutHistoryItem.', ''):
                      e,
                });

    return statusMap[status]!;
  }

  static String paymentMethodToString(PaymentMethod paymentMethod) {
    var paymentMethodMap =
        PaymentMethod.values.fold<Map<PaymentMethod, String>>(
            {},
            (p, e) => {
                  ...p,
                  e: e.toString().replaceFirst('PaymentMethod.', ''),
                });

    return paymentMethodMap[paymentMethod]!;
  }

  static String? bankToString(Bank? bank) {
    var bankMap = Bank.values.fold<Map<Bank, String>>(
        {},
        (p, e) => {
              ...p,
              e: e.toString().replaceFirst('Bank.', ''),
            });

    return bankMap[bank];
  }

  static String statusToString(StatusCheckoutHistoryItem status) {
    var statusMap = StatusCheckoutHistoryItem.values
        .fold<Map<StatusCheckoutHistoryItem, String>>(
            {},
            (p, e) => {
                  ...p,
                  e: e
                      .toString()
                      .replaceFirst('StatusCheckoutHistoryItem.', ''),
                });

    return statusMap[status]!;
  }
}
