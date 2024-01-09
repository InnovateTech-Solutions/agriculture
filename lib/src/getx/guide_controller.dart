import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:agriculture/src/model/guide_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideController extends GetxController {
  final controller = Get.put(ProfileController());

  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final area = TextEditingController();
  final description = TextEditingController();
  final image = TextEditingController();
  final _db = FirebaseFirestore.instance;

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  validArea(String? area) {
    if (area!.isEmpty) {
      return "Area is not valid";
    }
    return null;
  }

  validImage(String? image) {
    if (image!.isEmpty) {
      return "Image is not valid";
    }
    return null;
  }

  validDescription(String? description) {
    if (description!.isEmpty) {
      return "Description is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchAllGuide() async {
    List<Map<String, dynamic>> guide = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Guide').get();

    for (var doc in querySnapshot.docs) {
      guide.add(doc.data() as Map<String, dynamic>);
    }
    return guide;
  }

  Future<List<GuidModel>> fetchGuideDetails() async {
    final querySnapshot =
        await _db.collection('Guide').where('Area', isEqualTo: "Amman").get();

    return querySnapshot.docs
        .map((doc) => GuidModel.fromSnapshot(doc))
        .toList();
  }
}
