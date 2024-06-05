import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/features/authentication/controllers/login/login_controller.dart';
import 'package:store/features/authentication/screens/create_account.dart';
import 'package:store/features/authentication/screens/forgot_password.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/constants/text_string.dart';
import 'package:store/utils/theme/theme.dart';
import 'package:store/utils/validators/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Text(
                    TextString.loginWelcomeText,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  child: Text(
                    TextString.loginDescriptionText,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        decoration: InputDecoration(
                          hintText: "E-Mail",
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          obscureText: !controller.hidePassword.value,
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
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
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.toggleRemember();
                          }),
                      Text(
                        "Remember Me",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPasswordScreen()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 80),
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.emailAndPasswordSignIn();
                    },
                    child: const Text("Sign In"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey, width: 1),
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 1,
                      width: 80,
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "   Or Sign In With   ",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 1,
                      width: 80,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Image(
                        image: AssetImage(ImageString.googleLogo),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 14, top: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Image(
                        image: AssetImage(ImageString.facebookLogo),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
