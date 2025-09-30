import 'package:bloc_pay/features/payment/domain/entities/payment_entity.dart';
import '../domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  Future<PaymentEntity> processPayment(double amount) async {

    await Future.delayed(const Duration(seconds: 1));

    return PaymentEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      date: DateTime.now(),
    );
  }
}
