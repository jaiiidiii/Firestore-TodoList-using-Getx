import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/user.dart';
import 'package:morphosis_demo/services/database.dart';
import 'package:morphosis_demo/views/baseModule/mainBottomBar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController emailController =
      TextEditingController(text: 'junaid@morphosis.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'Morphosis12345');

  final loginPageFormKey = GlobalKey<FormState>();

  Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
    super.onInit();
  }

  void login() async {
    try {
      if (!loginPageFormKey.currentState.validate()) {
        return null;
      }
      isLoading(true);

      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      print("UID: " + _authResult.user.uid);
      user = await Database().getUser(_authResult.user.uid);
      isLoading(false);

      if (user != null) {
        Get.to(() => MainBottombar());
      } else {
        _showAuthFailedDialog();
      }
    } catch (e) {
      isLoading(false);

      Get.snackbar(
        "Error signing in",
        e.message ?? '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      clear();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // final Authentication auth = new Authentication();
  // FirebaseUser user;

  // void doLogin() async {
  //   try {
  //     isLoading(true);
  //     final user =
  //         await auth.login(emailController.text, passwordController.text);
  //     isLoading(false);

  //     if (user != null) {
  //       onLogin(user);
  //       Get.to(() => MainBottombar());
  //     } else {
  //       _showAuthFailedDialog();
  //     }
  //   } catch (e) {
  //     print(e);
  //     isLoading(false);
  //   }
  // }

  // Show error if login unsuccessfull
  void _showAuthFailedDialog() {
    // flutter defined function

    Get.defaultDialog(
      title: 'Could not log in',
      middleText: 'Double check your credentials and try again',
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text('Close'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  // void onLogin(FirebaseUser user) {
  //   // setState(() {
  //   this.user = user;
  //   // });
  // }

  // void signOut() async {
  //   try {
  //     await auth.signOut();
  //     Get.find<UserController>().clear();
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error signing out",
  //       e.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
}
