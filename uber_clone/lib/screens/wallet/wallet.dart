import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {

  static const route = '/wallet';

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Valjda ce bit nekad nesto'),
      ),
    );
  }
}
