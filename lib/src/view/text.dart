import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final con = Get.put(ProfileController());
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: con.fetchGuidesWithSameArea(),
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No guides found with the same area.');
            } else {
              // Display the list of guides
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['Email']),
                    // You can customize this based on your guide document structure
                    // For example, you might want to display guide details here.
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
