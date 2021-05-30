import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/views/baseModule/mainBottomBar.dart';

import '../auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController emailController =
      TextEditingController(text: 'junaid@morphosis.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'Morphosis12345');

  @override
  void onInit() {
    // fetchTasks();
    super.onInit();
  }

  final Authentication auth = new Authentication();
  FirebaseUser user;

  void doLogin() async {
    try {
      isLoading(true);
      final user =
          await auth.login(emailController.text, passwordController.text);
      isLoading(false);

      if (user != null) {
        // Calling callback in TODOState
        onLogin(user);
        Get.to(() => MainBottombar());
      } else {
        _showAuthFailedDialog();
      }
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  // Show error if login unsuccessfull
  void _showAuthFailedDialog() {
    // flutter defined function

    Get.defaultDialog(
      title: 'Could not log in',
      middleText: 'Double check your credentials and try again',
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text('Close'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       title: new Text('Could not log in'),
    //       content: new Text('Double check your credentials and try again'),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         new FlatButton(
    //           child: new Text('Close'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void onLogin(FirebaseUser user) {
    // setState(() {
    this.user = user;
    // });
  }
}
