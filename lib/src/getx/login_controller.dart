import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/navbar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final email = TextEditingController();
  final password = TextEditingController();
  validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    } else {
      return "Email is not valid";
    }
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  Future<bool> login(String email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future onLogin() async {
    if (formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        String userType = await _getUserType(userCredential.user!.email!);

        if (userType == 'Farmer') {
          Get.to(const NavBarWidget());
        } else {
          Get.snackbar("ERROR", "Email or Password is invild",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConst.mainScaffoldBackgroundColor,
              backgroundColor: Colors.red);
        }
      } on FirebaseAuthException {
        Get.snackbar("ERROR", "Email or Password is invild",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("ERROR", "Email or Password is invild",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConst.mainScaffoldBackgroundColor,
          backgroundColor: Colors.red);
    }
    return;
  }

  Future<String> _getUserType(String email) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('User')
        .where('Email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first['UserType'];
    }

    return '';
  }
}
