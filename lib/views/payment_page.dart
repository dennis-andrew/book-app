import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget{
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Page"),
      ),
      body: Center(
        child: Text("Payment Successful !"),
      ),
    );
  }
}