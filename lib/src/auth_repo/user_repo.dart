// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_catch_error

import 'package:agriculture/src/getx/user_controller.dart';
import 'package:agriculture/src/model/guide_model.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final userController = Get.put(UserController());

  final _db = FirebaseFirestore.instance;

  late UserModel userModel;

  void setUserModel(UserModel userModel) {
    this.userModel = userModel;
  }

  late GuidModel guidModel;

  void setGuide(GuidModel guidModel) {
    this.guidModel = guidModel;
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("User").where("Email", isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
    userModel = userdata;

    return userdata;
  }

  Future<GuidModel> getUserGuideDetails(String email) async {
    final snapshot =
        await _db.collection("Guide").where("Email", isEqualTo: email).get();
    final guideData = snapshot.docs.map((e) => GuidModel.fromSnapshot(e)).first;
    guidModel = guideData;

    return guidModel; // }

    // Future<UserModel> getUserGuideDetails(String email) async {
    //   final snapshot =
    //       await _db.collection("User").where("Email", isEqualTo: email).get();
    //   final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).first;
    //   userModel = userdata;
    //   userController.saveUserInfo(userdata);

    //   return userdata;
    // }
  }
}
