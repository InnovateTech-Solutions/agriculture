import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController videoId = TextEditingController();

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchVideo() async {
    List<Map<String, dynamic>> video = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Video').get();

    for (var doc in querySnapshot.docs) {
      video.add(doc.data() as Map<String, dynamic>);
    }
    return video;
  }
}

class VideoModel {
  String title;
  String videoURL;
  VideoModel({required this.videoURL, required this.title});
  toJason() {
    return {"Title": title, "VideoId": videoURL};
  }
}
