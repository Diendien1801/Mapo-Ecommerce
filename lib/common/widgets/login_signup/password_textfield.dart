import 'package:flutter/material.dart';
import 'package:store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:store/utils/validators/validation.dart';

TextFormField passwordTextFormField(BuildContext context,SignupController controller, TextEditingController passwordController) {
  return TextFormField(
    obscureText: !controller.hidePassword.value,
    controller: passwordController,
    validator: (value) => TValidator.validatePassword(value),
    decoration: InputDecoration(
      hintText: "Password",
      prefixIcon: const Icon(Icons.lock),
      prefixIconColor: Theme.of(context).primaryColor,
      suffixIcon: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          // using provider to change the value of _isPasswordVisible
          controller.togglePasswordVisibility();
        },
        child: controller.hidePassword.value
            ? Icon(
                Icons.visibility,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.visibility_off,
                color: Theme.of(context).disabledColor,
              ),
      ),
    ),
  );
}
