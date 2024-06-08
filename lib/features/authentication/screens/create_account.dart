import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/common/widgets/login_signup/password_textfield.dart';
import 'package:store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/constants/text_string.dart';
import 'package:store/utils/validators/validation.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.signUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20),
                child: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  TextString.signUpWelcomeText,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        onTap: () {
                          //controller.signUpFormKey.currentState?.reset();
                        },
                        controller: controller.firstName,
                        validator: (value) =>
                            TValidator.validateEmptyText('First name', value),
                        decoration: InputDecoration(
                          hintText: "First Name",
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        onTap: () {
                          // controller.signUpFormKey.currentState?.reset();
                        },
                        controller: controller.lastName,
                        validator: (value) =>
                            TValidator.validateEmptyText('Last name', value),
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  onTap: () {
                    //controller.signUpFormKey.currentState?.reset();
                  },
                  controller: controller.userName,
                  validator: (value) =>
                      TValidator.validateEmptyText('User name', value),
                  decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: const Icon(Icons.person_outlined),
                    prefixIconColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  onTap: () {
                    //controller.signUpFormKey.currentState?.reset();
                  },
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: InputDecoration(
                    hintText: "E-Mail",
                    prefixIcon: const Icon(Icons.email),
                    prefixIconColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  onTap: () {
                    //controller.signUpFormKey.currentState?.reactive();
                  },
                  controller: controller.phone,
                  validator: (value) => TValidator.validatePhone(value),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone_outlined),
                    prefixIconColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Obx(
                  () => passwordTextFormField(
                      context, controller, controller.password),
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isCheck.value,
                      onChanged: (value) {
                        controller.toggleCheck();
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "I agree to the ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: "Privacy Policy ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const TextSpan(
                          text: "and ",
                        ),
                        TextSpan(
                          text: "Terms of use",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: ElevatedButton(
                  onPressed: () {
                    controller.signUp();
                  },
                  child: const Text("Create Account"),
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
    );
  }
}
