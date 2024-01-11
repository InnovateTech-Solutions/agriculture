import 'package:agriculture/src/auth_repo/auth_repo.dart';
import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/user_custom.dart/form_widget/register_dialog.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final idNumber = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final _db = FirebaseFirestore.instance;

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  String selectedArea = 'Amman'; // Default value

  final List<String> areas = [
    'Amman',
    'Irbid',
    'Madaba',
    'Ajloun',
    'Jerash',
    'Ma\'an',
    'Karak',
    'Ghor al-Urdun',
  ];

  validEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return "Email is not valid";
  }

  validIdNumber(String? id) {
    if (id!.isEmpty) {
      return "ID Number is not valid";
    }
    return null;
  }

  validAddress(String? address) {
    if (address!.isEmpty) {
      return "Address is not valid";
    }
    return null;
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  vaildateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<bool> isUsernameTaken(String username) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('User')
          .where('UserName', isEqualTo: username)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      Get.snackbar("Error", "Error checking username: $error",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConst.mainScaffoldBackgroundColor,
          backgroundColor: Colors.red);
      return false;
    }
  }

  Future<void> createUser(UserModel user) async {
    await _db
        .collection("User")
        .add(user.tojason())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green))
        .catchError((error) {
      Get.snackbar(error.toString(), "Something went wrong , try agin",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConst.mainScaffoldBackgroundColor,
          backgroundColor: Colors.red);
      throw error;
    });
  }

  Future<void> onSignup(UserModel user, BuildContext context) async {
    if (formkey.currentState!.validate()) {
      bool usernameCheck = await isUsernameTaken(user.name);
      if (!usernameCheck) {
        Future<bool> code = AuthenticationRepository()
            .createUserWithEmailPassword(user.email, user.password);
        if (await code) {
          createUser(user);
          Get.snackbar("Success", " Account  Created Successfullly",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConst.mainScaffoldBackgroundColor,
              backgroundColor: Colors.green);
          // ignore: use_build_context_synchronously
          addFarmDialog(context);
        } else {
          Get.snackbar("ERROR", "Invalid datas",
              snackPosition: SnackPosition.BOTTOM,
              colorText: ColorConst.mainScaffoldBackgroundColor,
              backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("ERROR", "Username  is taken",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.red);
      }
    }
  }
}
