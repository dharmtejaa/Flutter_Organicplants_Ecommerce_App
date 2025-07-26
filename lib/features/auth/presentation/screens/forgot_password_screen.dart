// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Column(children: [Text("Forgot Password")])),
      ),
    );
  }
}
