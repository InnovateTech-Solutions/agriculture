import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:agriculture/src/view/user_pages/view_all_video.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/dashboard_title.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/video_widget.dart';
import 'package:agriculture/src/widget/user_custom.dart/guide_image_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidPage extends StatelessWidget {
  const GuidPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: controller.getUserDataForFarmer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  UserModel userData = snapshot.data as UserModel;

                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: headerText("Guide"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 250,
                              child: GuideImageName(
                                area: userData.address,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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
