import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/payment_entity.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentInitial()) {
    on<AddPayment>((event, emit) {
      final currentPayments = List<PaymentEntity>.from(state is PaymentInitial
          ? (state as PaymentInitial).payments
          : (state as PaymentUpdated).payments);

      currentPayments.add(event.payment);
      emit(PaymentUpdated(currentPayments));
    });

    on<DeletePayment>((event, emit) {
      final currentPayments = List<PaymentEntity>.from(state is PaymentInitial
          ? (state as PaymentInitial).payments
          : (state as PaymentUpdated).payments);

      currentPayments.removeWhere((p) => p.id == event.paymentId);
      emit(PaymentUpdated(currentPayments));
    });
  }
}
