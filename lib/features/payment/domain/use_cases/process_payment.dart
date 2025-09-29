import 'package:bloc_pay/features/payment/domain/entities/payment_entity.dart';

import '../repositories/payment_repository.dart';

///defines data access contract.
class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment(this.repository);

  Future<PaymentEntity> call(double amount) {
    return repository.processPayment(amount);
  }
}
