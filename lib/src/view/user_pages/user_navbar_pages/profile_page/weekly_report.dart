import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/weekly_report_controller.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/profile_page/weekly_report_dialog.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminWeeklyReportView extends StatelessWidget {
  const AdminWeeklyReportView({super.key, required this.farmerId});
  final String farmerId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyReportController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorConst.secScaffoldBackgroundColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.fetchAllWeeklyReport(farmerId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              final report = snapshot.data!;

              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        headerText("Weekly Report"),
                        const SizedBox(height: 25),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              RxBool isReviewed = false.obs; // Add this line

                              return Container(
                                height: 200,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: ColorConst.mainScaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(.2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color:
                                        ColorConst.secScaffoldBackgroundColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      headerText(
                                          "Farm IdNumber: ${report[index]["IdNumber"]}"),
                                      headerText(
                                          "Farm IdNumber: ${report[index]["FarmName"]}"),
                                      secText(
                                          "Shortfalls: ${report[index]["Missing"]} "),
                                      secText(
                                          "Report: ${report[index]["Message"]} "),
                                      Row(
                                        children: [
                                          secText(
                                              "Rating: ${report[index]["Rating"]}"),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18.0,
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (isReviewed.isFalse) {
                                            Get.to(WeeklyReportDialog(
                                              hasReviewed: isReviewed.value,
                                              adminEmail: report[index]
                                                  ["GuideEmail"],
                                              reportMessage: report[index]
                                                  ["Message"],
                                            ));
                                            isReviewed.value = true;
                                          } else if (isReviewed.isTrue) {
                                            print(isReviewed.value);
                                            Get.snackbar(
                                                "Review has been added", "",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                colorText: ColorConst
                                                    .mainScaffoldBackgroundColor,
                                                backgroundColor: ColorConst
                                                    .secScaffoldBackgroundColor);
                                          }
                                        },
                                        child: Obx(() =>
                                            isReviewed.value == false
                                                ? Text("Add Review")
                                                : Container()),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: report.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
