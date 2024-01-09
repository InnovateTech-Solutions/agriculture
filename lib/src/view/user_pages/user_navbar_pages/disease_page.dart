import 'package:agriculture/src/getx/disease_controller.dart';
import 'package:agriculture/src/model/disease_model.dart';
import 'package:agriculture/src/view/user_pages/disease_detail_page.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiseaseController());
    return Scaffold(
      body: FutureBuilder(
        future: controller.fetchDiseaseDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No information available ');
          } else {
            final disease = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  headerText("DISEASES"),
                  const SizedBox(height: 25),
                  Expanded(
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(DiseaseDetailPage(
                                disease: Disease(
                                    name: disease[index]['name'],
                                    control: List<String>.from(
                                        disease[index]['Control']),
                                    symptoms: List<String>.from(
                                        disease[index]['Symptoms']),
                                    transmission: disease[index]
                                        ['Transmission'],
                                    image: disease[index]['image'])));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: 180,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            disease[index]['image']),
                                        fit: BoxFit.cover)),
                              ),
                              secText(disease[index]['name'])
                            ],
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: disease.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
