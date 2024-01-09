import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController control = TextEditingController();
  final TextEditingController symptoms = TextEditingController();
  final TextEditingController transmission = TextEditingController();
  final TextEditingController image = TextEditingController();

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchDiseaseDetails() async {
    List<Map<String, dynamic>> disease = [];

    final QuerySnapshot<Map<String, dynamic>> result =
        await FirebaseFirestore.instance.collection('Disease').get();
    for (var doc in result.docs) {
      disease.add(doc.data());
    }
    return disease;
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
    image.text = imageUrl;
  }
}
