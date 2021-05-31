import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/user.dart';
import 'package:morphosis_demo/services/database.dart';
import 'package:morphosis_demo/views/baseModule/mainBottomBar.dart';

import '../auth.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController emailController =
      TextEditingController(text: 'junaid@morphosis.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'Morphosis12345');

  Rx<UserModel> _userModel = UserModel().obs;
  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<FirebaseUser> _firebaseUser = Rx<FirebaseUser>();

  // FirebaseUser get user => _firebaseUser.value;

  @override
  void onInit() {
    // createUser();
    _firebaseUser.bindStream(_auth.onAuthStateChanged);
    super.onInit();
  }

  void createUser() async {
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      //create user in database.dart
      UserModel _user = UserModel(
        id: _authResult.user.uid,
        name: 'Junaid Ahmed Khan',
        email: _authResult.user.email,
      );
      if (await Database().createNewUser(_user)) {
        user = _user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login() async {
    try {
      isLoading(true);

      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
          print("UID: "+_authResult.user.uid);
      user = await Database().getUser(_authResult.user.uid);
      isLoading(false);

      if (user != null) {
        // onLogin(user);
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
        new FlatButton(
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
