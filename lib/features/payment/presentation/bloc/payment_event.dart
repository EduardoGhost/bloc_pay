import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class SubmitPayment extends PaymentEvent {
  final double amount;

  const SubmitPayment(this.amount);

  @override
  List<Object?> get props => [amount];
}
