import 'package:flutter/material.dart';

class WishesPage extends StatefulWidget {
  const WishesPage({super.key});

  @override
  _WishesPageState createState() => _WishesPageState();
}

class _WishesPageState extends State<WishesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'DESEOS',
        ),
      ),
    );
  }
}
