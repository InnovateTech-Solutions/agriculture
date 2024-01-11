import 'package:agriculture/src/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//controller
class WeeklyReportController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final missing = TextEditingController();
  final message = TextEditingController();
  RxString rating = "".obs;

  validText(String? text) {
    if (text!.isEmpty) {
      return "Data is not valid";
    }
    return null;
  }

  ratingValue(value) {
    rating.value = value.toString();

    return rating.value;
  }

  Future<void> addWeeklyReport(String email, String rating) async {
    if (formkey.currentState!.validate()) {
      try {
        Get.back();

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Guide')
            .where("Email", isEqualTo: email)
            .get();

        QueryDocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        await documentSnapshot.reference.update({
          'rating': rating, // Initial rating value
        });

        Get.snackbar("Success", "Your Report has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);
      } catch (e) {
        Get.snackbar("Error", "Failed to add Report",
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

  Future<List<Map<String, dynamic>>> fetchAllWeeklyReport(String id) async {
    List<Map<String, dynamic>> report = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('WeeklyReport')
        .where("IdNumber", isEqualTo: id)
        .get();

    for (var doc in querySnapshot.docs) {
      report.add(doc.data() as Map<String, dynamic>);
    }
    return report;
  }
}

//model
class WeeklyReportModel {
  String rating;
  String guideEmail;
  String farmName;
  String farmId;
  String missing;
  String message;

  WeeklyReportModel({
    required this.rating,
    required this.farmName,
    required this.guideEmail,
    required this.farmId,
    required this.missing,
    required this.message,
  });
  toJason() {
    return {
      "Rating": rating,
      "IdNumber": farmId,
      "GuideEmail": guideEmail,
      "FarmName": farmName,
      "Missing": missing,
      "Message": message,
    };
  }
}
