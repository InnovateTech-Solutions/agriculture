import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/category_controlller.dart';
import 'package:agriculture/src/model/category_model.dart';
import 'package:agriculture/src/view/user_pages/category_pages/fruit_page.dart';
import 'package:agriculture/src/view/user_pages/category_pages/vegetables_page.dart';
import 'package:agriculture/src/widget/user_custom.dart/category_widget/fruits_widget.dart';
import 'package:agriculture/src/widget/user_custom.dart/category_widget/vegetables_widget.dart';
import 'package:agriculture/src/widget/user_custom.dart/dashboard_widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryContrller());
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConst.mainScaffoldBackgroundColor,
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.fetchAllCategories(),
          builder: (context, snapshot) {
            {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Categories",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: ColorConst.mainTextColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                            Divider(
                                height: 20,
                                thickness: 2,
                                color: ColorConst.secScaffoldBackgroundColor),
                            Row(
                              children: [
                                SizedBox(
                                  width: 370,
                                  height: 200,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    itemBuilder: ((context, index) {
                                      final categoryName =
                                          categories[index]['Category'];

                                      final categoryImageURL =
                                          categories[index]['Image'];
                                      return CategoryWidget(
                                        model: CategoryModel(
                                            image: categoryImageURL,
                                            title: categoryName,
                                            callback: () {
                                              categories[index]['Category'] ==
                                                      "Fruits"
                                                  ? Get.to(const FruitPage())
                                                  : Get.to(
                                                      const VegetablePage());
                                            }),
                                      );
                                    }),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 20,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              "Popular vegetables",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: ColorConst.mainTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 375,
                              height: 200,
                              child: VegetablesCategoryWidget(),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              "Popular Fruits",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: ColorConst.mainTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 375,
                              height: 200,
                              child: FruitCategoryWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error${snapshot.error}'));
                } else {
                  return const Text("something went wrong1");
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return const Text("somthing went wrong3");
              }
            }
          }),
    ));
  }
}
