import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/payment_repository_impl.dart';
import '../../domain/use_cases/process_payment.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(
        processPayment: ProcessPayment(PaymentRepositoryImpl()),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("BlocPay")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Valor do pagamento"),
              ),
              const SizedBox(height: 20),
              BlocConsumer<PaymentBloc, PaymentState>(
                listener: (context, state) {
                  if (state is PaymentSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Pagamento aprovado: \$${state.payment.amount}")),
                    );
                  } else if (state is PaymentFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Pagamento falhou: ${state.message}")),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is PaymentLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final amount = double.tryParse(_controller.text) ?? 0;
                      context.read<PaymentBloc>().add(SubmitPayment(amount));
                    },
                    child: const Text("Pagar"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
