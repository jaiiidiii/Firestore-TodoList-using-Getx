import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/views/loginModule/loginController.dart';
import 'package:morphosis_demo/widgets/customLoaderWidget.dart';

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
                  child: Column(
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
                      ElevatedButton(
                        onPressed: () => loginController.login(),
                        child: Text(
                          'LOGIN',
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ))),
        ));
  }
}
