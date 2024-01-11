import 'package:agriculture/src/auth_repo/auth_repo.dart';
import 'package:agriculture/src/auth_repo/user_repo.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  late UserModel userModel;

  Future<List<DocumentSnapshot>> fetchGuidesWithSameArea() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final _authRepo = Get.put(AuthenticationRepository());
    User? user = auth.currentUser;

    if (user != null) {
      String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(currentUserEmail)
          .get();

      if (userSnapshot.exists) {
        String currentUserArea = userSnapshot['Address'];

        QuerySnapshot guideQuery = await FirebaseFirestore.instance
            .collection('Guide')
            .where('Area', isEqualTo: currentUserArea)
            .get();

        return guideQuery.docs;
      }
    } else {
      print("object");
    }

    return [];
  }

// user Details
  getUserDataForFarmer() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllFarm(String idNumber) async {
    List<Map<String, dynamic>> farm = [];

    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('farms')
        .where("IdNumber", isEqualTo: idNumber)
        .get();
    for (var doc in result.docs) {
      farm.add(doc.data());
    }
    return farm;
  }
}
