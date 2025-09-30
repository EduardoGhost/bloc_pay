import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/payment_entity.dart';
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
    return Scaffold(
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
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_controller.text) ?? 0;
                if (amount <= 0) return;

                final payment = PaymentEntity(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  amount: amount,
                  date: DateTime.now(),
                );

                context.read<PaymentBloc>().add(AddPayment(payment));
                _controller.clear();
              },
              child: const Text("Adicionar Pagamento"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  final payments = state is PaymentInitial
                      ? state.payments
                      : state is PaymentUpdated
                      ? state.payments
                      : <PaymentEntity>[];

                  if (payments.isEmpty) {
                    return const Center(child: Text("Nenhum pagamento ainda"));
                  }

                  return ListView.builder(
                    itemCount: payments.length,
                    itemBuilder: (context, index) {
                      final payment = payments[index];
                      return ListTile(
                        title: Text("\$${payment.amount.toStringAsFixed(2)}"),
                        subtitle: Text(payment.date.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<PaymentBloc>()
                                .add(DeletePayment(payment.id));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
