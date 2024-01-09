import 'package:agriculture/src/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final message = TextEditingController();
  final email = TextEditingController();
  final formkey = GlobalKey<FormState>();

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  Future<void> addReport(ReportModel report) async {
    if (formkey.currentState!.validate()) {
      try {
        Get.back();

        await FirebaseFirestore.instance
            .collection('Report')
            .add(report.tojason());
        Get.snackbar("Success", "Your Farm has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);
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
}

class ReportModel {
  String farmerName;
  String message;
  String email;
  ReportModel({
    required this.farmerName,
    required this.message,
    required this.email,
  });

  tojason() {
    return {"Farmer name": farmerName, "Message": message, "Guide": email};
  }

  factory ReportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return ReportModel(
      farmerName: data['Farmer name'],
      message: data['Message'],
      email: data['Guide'],
    );
  }
}
