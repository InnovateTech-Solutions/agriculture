import 'dart:io';

import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/register_controller.dart';
import 'package:agriculture/src/model/farm_model.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/navbar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFarmController extends GetxController {
  static AddFarmController get instance => Get.find();
  final formkey = GlobalKey<FormState>();

  final farmName = TextEditingController();
  final farmAddress = TextEditingController();
  final area = TextEditingController();
  final typeOfFarming = TextEditingController();
  final idNumber = TextEditingController();
  final imageFile = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final controller = Get.put(RegisterController());
  String imageUrl = '';

  validName(String? name) {
    if (name!.isEmpty) {
      return "Data is not valid";
    }
    return null;
  }

  validFarmerIdNumber(String? name) {
    if (controller.idNumber != idNumber) {
      return "ID number does not match";
    }
    return null;
  }

  Future<void> createFarm(FarmModel farm) async {
    await _db.collection("farms").add(farm.tojason());
  }

  farmingList(List<String> list) {
    typeOfFarming.text = list.toString();
  }

  Future<void> addFarm(FarmModel farm) async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('farms')
            .add(farm.tojason());
        Get.snackbar("Success", "Your Farm has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);
        Get.offAll(const NavBarWidget());
      } catch (e) {
        Get.snackbar("Error", "Failed to add farm",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("ERROR", "Invalid data",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConst.mainScaffoldBackgroundColor,
          backgroundColor: Colors.red);
    }
  }

  pickFarmImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images').child('filename.jpg');
    await storageReference.putFile(File(file.path));

    String imageUrl = await storageReference.getDownloadURL();
    imageFile.text = imageUrl;
  }
}
