import 'package:flutter/material.dart';
import 'features/payment/presentation/pages/payment_page.dart';

void main() {
  runApp(const BlocPayApp());
}

class BlocPayApp extends StatelessWidget {
  const BlocPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlocPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentPage(),
    );
  }
}
