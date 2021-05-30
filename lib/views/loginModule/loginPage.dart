import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/views/loginModule/loginController.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

// As login page has to handle user input, it has to be stateful
class LoginPage extends StatelessWidget {
  final LoginController loginController =
      Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomLoaderWidget(
          isTrue: loginController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(title: Text('Please log in')),
              body: Padding(
                  padding: EdgeInsets.all(16),
                  // Align widgets in a vertical column
                  child: Column(
                    // Passing multiple widgets as children to Column
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextField(
                            controller: loginController.emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: TextField(
                            controller: loginController.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password'),
                          )),
                      RaisedButton(
                        // Calling the callback with the supplied email and password
                        onPressed: () => loginController.doLogin(),
                        // widget.onLogin(
                        //     emailController.text, passwordController.text),
                        child: Text('LOGIN'),
                        // Setting the primary color on the button
                        color: ThemeData().primaryColor,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ))),
        ));
  }
}
