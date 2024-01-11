import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/guide_controller.dart';
import 'package:agriculture/src/model/guide_model.dart';
import 'package:agriculture/src/view/user_pages/guidedetail_page.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GuideImageName extends StatelessWidget {
  const GuideImageName({super.key, required this.area});
  final String area;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuideController());
    return FutureBuilder(
        future: controller.fetchGuideDetails(area),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            final guide = snapshot.data;

            return guide == null
                ? Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: guide!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final email = guide[index].email;
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
                                    borderRadius: BorderRadius.circular(20),
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
                  )
                : Center(
                    child: Text(
                    "There is no Guide Assign For This farm",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18, color: ColorConst.mainTextColor)),
                  ));
          }
        });
  }
}
