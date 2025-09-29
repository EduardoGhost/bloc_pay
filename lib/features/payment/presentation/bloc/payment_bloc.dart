import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/process_payment.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ProcessPayment processPayment;

  PaymentBloc({required this.processPayment}) : super(PaymentInitial()) {
    on<SubmitPayment>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payment = await processPayment.call(event.amount);
        emit(PaymentSuccess(payment));
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
  }
}
