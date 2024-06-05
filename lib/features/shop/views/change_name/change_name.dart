import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:store/features/shop/controllers/update_name_controller.dart';
import 'package:store/utils/validators/validation.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Change name'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.firstName,
                validator: (value) =>
                    TValidator.validateEmptyText('First Name', value),
                decoration: InputDecoration(
                  hintText: "First Name",
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Theme.of(context).primaryColor,
                ),
              ),
              TextFormField(
                controller: controller.lastName,
                validator: (value) =>
                    TValidator.validateEmptyText('Last Name', value),
                decoration: InputDecoration(
                  hintText: "Last Name",
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: Theme.of(context).primaryColor,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  
                  controller.updateUserName();
                },
                child: Text(
                  'Submit',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
