import 'package:agriculture/src/getx/guide_controller.dart';
import 'package:agriculture/src/model/guide_model.dart';
import 'package:agriculture/src/view/user_pages/guidedetail_page.dart';
import 'package:agriculture/src/view/user_pages/view_all_video.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/dashboard_title.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidPage extends StatelessWidget {
  const GuidPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuideController());
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: controller.fetchGuideDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  final guide = snapshot.data;

                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: headerText("Guide"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            height: 300,
                            width: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                final email = guide![index].email;
                                final name = guide[index].name;
                                final area = guide[index].area;
                                final description = guide[index].description;
                                final image = guide[index].image;
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(GuideDetailPage(
                                        guidModel: GuidModel(
                                            password: "",
                                            userType: "Guide",
                                            email: email,
                                            name: name,
                                            area: area,
                                            description: description,
                                            image: image)));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 250,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(image),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      secText(name)
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        headerTitle("Popular video", () {
                          Get.to(const ViewViedo());
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        const VideoWidget(),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
