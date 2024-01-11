import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/weekly_report_controller.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class WeeklyReportDialog extends StatefulWidget {
  WeeklyReportDialog(
      {super.key,
      required this.hasReviewed,
      required this.adminEmail,
      required this.reportMessage});
  bool hasReviewed;
  String adminEmail;
  String reportMessage;

  @override
  State<WeeklyReportDialog> createState() => _WeeklyReportDialogState();
}

class _WeeklyReportDialogState extends State<WeeklyReportDialog> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyReportController());

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: controller.formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 350,
              height: 650,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  headerText("Message :${widget.reportMessage}"),
                  headerText("Guide Email: ${widget.adminEmail}"),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          controller.rating.value = rating.toString();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                    title: "Add",
                    onTap: () {
                      print(widget.hasReviewed);
                      controller.addWeeklyReport(
                          widget.adminEmail, controller.rating.value);
                    },
                    containerColor: ColorConst.secScaffoldBackgroundColor,
                    textColor: ColorConst.mainScaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
