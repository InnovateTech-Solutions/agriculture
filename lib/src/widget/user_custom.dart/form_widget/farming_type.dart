import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/add_farm_controller.dart';
import 'package:agriculture/src/getx/dashboard_controller.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final selectedContainers = <String>[].obs;
final Color selectedColor = ColorConst.secTextColor;
final controller = Get.put(AddFarmController());
final subcategoryController = Get.put(DashboardController());

void addFarmingType(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: FutureBuilder(
          future: subcategoryController.fetchAllSubCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              final subCategory = snapshot.data!;
              return SizedBox(
                  height: 800,
                  width: 200,
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: subCategory.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 110,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: ((context, index) {
                            return dayWidget(subCategory[index]["name"]);
                          })),
                    ],
                  ));
            }
          },
        ),
        actions: [
          SizedBox(
            height: 50,
            width: 80,
            child: ButtonWidget(
                title: "Add",
                onTap: () {
                  controller.farmingList(selectedContainers);
                  Get.back();
                },
                containerColor: ColorConst.secScaffoldBackgroundColor,
                textColor: ColorConst.mainScaffoldBackgroundColor),
          )
        ],
      );
    },
  );
}

dayWidget(String title) {
  return GestureDetector(
    onTap: () {
      if (selectedContainers.contains(title)) {
        selectedContainers.remove(title);
      } else {
        selectedContainers.add(title);
      }
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(() {
        final isSelected = selectedContainers.contains(title);

        return Container(
          width: 95,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isSelected
                ? selectedColor
                : ColorConst.secScaffoldBackgroundColor,
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  color: ColorConst.mainScaffoldBackgroundColor),
            ),
          ),
        );
      }),
    ),
  );
}
