import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/utils/validators.dart';
import 'package:morphosis_demo/views/loginModule/loginController.dart';
import 'package:morphosis_demo/views/registrationModule/registrationPage.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController =
      Get.put<LoginController>(LoginController());
  final _validator = Validators();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: loginController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Morphosis Demo App'),
                centerTitle: true,
              ),
              body: Form(
                key: loginController.loginPageFormKey,
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: TextFormField(
                              validator: _validator.validateEmail,
                              controller: loginController.emailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: TextFormField(
                              controller: loginController.passwordController,
                              validator: _validator.validateExistingPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                          child: ElevatedButton(
                            onPressed: () => loginController.login(),
                            child: Text(
                              'LOGIN',
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Need an account ? ",
                                  style: TextStyle(
                                    // color: ThemeConstants.primaryColor,
                                    // fontFamily: defaultFontFamily,
                                    // fontSize: defaultFontSize,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(RegistrationPage());
                                },
                                child: Container(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        // color: ThemeConstants.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    )),
              )),
        ));
  }
}
