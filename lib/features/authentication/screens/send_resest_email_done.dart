import 'package:flutter/material.dart';
import 'package:store/features/authentication/screens/login.dart';

class SendEmailDone extends StatelessWidget {
  const SendEmailDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text("Email Sent"),
        ElevatedButton(
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text("Done"))
      ],
    ));
  }
}
