import 'package:bloc_pay/features/payment/domain/entities/payment_entity.dart';

///Executes the rule to process a payment.
abstract class PaymentRepository {
  Future<PaymentEntity> processPayment(double amount);
}
