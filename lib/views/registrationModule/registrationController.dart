import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/model/user.dart';
import 'package:morphosis_demo/services/database.dart';

class RegistrationController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final registerPageFormKey = GlobalKey<FormState>();

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

  void createUser() async {
    try {
      if (!registerPageFormKey.currentState.validate()) {
        return null;
      }
      isLoading(true);
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      UserModel _user = UserModel(
        id: _authResult.user.uid,
        name: nameController.text,
        email: _authResult.user.email,
      );
      if (await Database().createNewUser(_user)) {
        user = _user;
        Get.back();
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);

      Get.snackbar(
        "Error creating Account",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
