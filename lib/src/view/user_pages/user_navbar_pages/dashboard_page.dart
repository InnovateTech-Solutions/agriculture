import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/dashboard_controller.dart';
import 'package:agriculture/src/model/category_model.dart';
import 'package:agriculture/src/model/subcategory_model.dart';
import 'package:agriculture/src/view/user_pages/category_pages/plant_page.dart';
import 'package:agriculture/src/view/user_pages/category_pages/subcategory_page.dart';
import 'package:agriculture/src/view/user_pages/view_all_video.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/category_widget.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/dashboard_title.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/slider_widget.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConst.mainScaffoldBackgroundColor,
            body: FutureBuilder(
              future: dashboardController.fetchAllSubCategories(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  final subCategory = snapshot.data!;

                  return Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 18),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello Farmer',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          ColorConst.secScaffoldBackgroundColor,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ImageSlider(),
                            const SizedBox(
                              height: 20,
                            ),
                            headerTitle("Our Latest Video", () {
                              Get.to(const ViewViedo());
                            }),
                            const VideoWidget(),
                            headerTitle("Recently visit", () {
                              Get.to(const SubCategoryPage());
                            }),
                            Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  height: 300,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final name = subCategory[index]['name'];

                                        final image =
                                            subCategory[index]['image'];
                                        final flowering =
                                            subCategory[index]['Flowering'];
                                        final harvesting =
                                            subCategory[index]['Harvesting'];
                                        final planting =
                                            subCategory[index]['Planting'];
                                        final soil = subCategory[index]['Soil'];
                                        final transplanting =
                                            subCategory[index]['Transplanting'];
                                        final varieties =
                                            subCategory[index]['Varieties'];
                                        final watering =
                                            subCategory[index]['Watering'];
                                        final category =
                                            subCategory[index]['Categories '];
                                        final disease =
                                            subCategory[index]['Disease'];

                                        return CategoryWidget(
                                            model: CategoryModel(
                                                callback: () {
                                                  Get.to(PlantPage(
                                                      subCategory:
                                                          SubCategoryModel(
                                                              planting:
                                                                  planting,
                                                              soil: soil,
                                                              transplanting:
                                                                  transplanting,
                                                              varieties:
                                                                  varieties,
                                                              watering:
                                                                  watering,
                                                              category:
                                                                  category,
                                                              flowering:
                                                                  flowering,
                                                              harvesting:
                                                                  harvesting,
                                                              image: image,
                                                              name: name,
                                                              disease:
                                                                  disease)));
                                                },
                                                image: image,
                                                title: name));
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 20,
                                        );
                                      },
                                      itemCount: subCategory.length),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                }
              },
            )));
  }
}
