import 'package:equatable/equatable.dart';
import '../../domain/entities/payment_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  final List<PaymentEntity> payments;
  const PaymentInitial([this.payments = const []]);

  @override
  List<Object?> get props => [payments];
}

class PaymentUpdated extends PaymentState {
  final List<PaymentEntity> payments;
  const PaymentUpdated(this.payments);

  @override
  List<Object?> get props => [payments];
}
