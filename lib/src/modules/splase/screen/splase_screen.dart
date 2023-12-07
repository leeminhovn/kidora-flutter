import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kidora/config/router_name.dart';

class SplaseScreen extends StatefulWidget {
  const SplaseScreen({super.key});

  @override
  State<SplaseScreen> createState() => _SplaseScreenState();
}

class _SplaseScreenState extends State<SplaseScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      context.pushReplacementNamed(ApplicationRouteName.dashboard);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'intro showing...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
