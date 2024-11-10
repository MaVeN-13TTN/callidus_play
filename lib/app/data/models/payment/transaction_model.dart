class Transaction {
  final int id;
  final int orderId;
  final String transactionId;
  final String status;
  final double amount;
  final String currency;
  final String paymentMethod;
  final DateTime createdAt;

  Transaction({
    required this.id,
    required this.orderId,
    required this.transactionId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        orderId: json['order_id'],
        transactionId: json['transaction_id'],
        status: json['status'],
        amount: double.parse(json['amount'].toString()),
        currency: json['currency'],
        paymentMethod: json['payment_method'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'transaction_id': transactionId,
        'status': status,
        'amount': amount,
        'currency': currency,
        'payment_method': paymentMethod,
        'created_at': createdAt.toIso8601String(),
      };
}
