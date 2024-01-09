import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdsController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchAds() async {
    List<Map<String, dynamic>> ads = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ads').get();

    for (var doc in querySnapshot.docs) {
      ads.add(doc.data() as Map<String, dynamic>);
    }
    return ads;
  }
}
