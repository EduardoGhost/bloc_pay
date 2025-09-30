
class PaymentEntity {
  final String id;
  final double amount;
  final DateTime date;
 // final PaymentStatus status;

  const PaymentEntity({
    required this.id,
    required this.amount,
    required this.date,
   // required this.status,
  });
}

enum PaymentStatus {
  pending,
  success,
  failure,
}
