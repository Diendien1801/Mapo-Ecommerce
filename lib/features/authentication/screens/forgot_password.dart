import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/authentication/controllers/forget_password/forget_password.dart';
import 'package:store/utils/validators/validation.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.forgetPasswordformKey,
          child: Column(
            children: [
              const Text("Forgot Password"),
              TextFormField(
                controller: controller.email,
                validator: (value) {
                  TValidator.validateEmail(value);
                  return null;
                  
                },
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.sendPasswordResetEmail();
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
