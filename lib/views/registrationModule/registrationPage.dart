import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/utils/validators.dart';
import 'package:morphosis_demo/views/registrationModule/registrationController.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController registrationController =
      RegistrationController();
  final _validator = Validators();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: registrationController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(title: Text('Please Register')),
              body: Form(
                key: registrationController.registerPageFormKey,
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: TextFormField(
                                controller:
                                    registrationController.nameController,
                                validator: _validator.required,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: TextFormField(
                                controller:
                                    registrationController.emailController,
                                validator: _validator.validateEmail,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email'),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: TextFormField(
                                controller:
                                    registrationController.passwordController,
                                validator: _validator.validateExistingPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password'),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                16,
                                0,
                                16,
                              ),
                              child: TextFormField(
                                validator: (value) =>
                                    _validator.validateConfirmPassword(
                                        value,
                                        registrationController
                                            .passwordController.text),
                                controller: registrationController
                                    .confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Confirm Password'),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                            child: ElevatedButton(
                              onPressed: () =>
                                  registrationController.createUser(),
                              child: Text(
                                'REGISTER',
                              ),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    )),
              )),
        ));
  }
}
