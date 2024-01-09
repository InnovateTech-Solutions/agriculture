import 'package:agriculture/src/model/subcategory_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  final String plant;
  SubCategoryController(this.plant);
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final category = TextEditingController();
  final flowering = TextEditingController();
  final harvesting = TextEditingController();
  final planting = TextEditingController();
  final soil = TextEditingController();
  final transplanting = TextEditingController();
  final varieties = TextEditingController();
  final watering = TextEditingController();
  final image = TextEditingController();
  final _db = FirebaseFirestore.instance;
  RxString selectedItem = "".obs;

  validName(String? field) {
    if (field!.isEmpty) {
      return "Field is not valid";
    }
    return null;
  }

  Future<List<SubCategoryModel>> fetchPlantByCategory(String category) async {
    final querySnapshot = await _db
        .collection('subcategories ')
        .where('name', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => SubCategoryModel.fromSnapshot(doc))
        .toList();
  }
}
