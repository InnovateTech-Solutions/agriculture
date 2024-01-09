// ignore_for_file: prefer_const_constructors

import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/model/guide_model.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideDetailPage extends StatelessWidget {
  const GuideDetailPage({super.key, required this.guidModel});
  final GuidModel guidModel;
  @override
  Widget build(BuildContext context) {
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
          backgroundColor: ColorConst.mainScaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 200,
                        height: 220,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(guidModel.image),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          thirdText(guidModel.name),
                          thirdText(guidModel.area),
                          GestureDetector(
                              onTap: () {
                                Get.to(
                                    ReportDialog(guideName: guidModel.email));
                              },
                              child: Icon(
                                Icons.chat_outlined,
                                color: ColorConst.iconColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 3,
                    color: ColorConst.iconColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  thirdText(guidModel.description),
                ],
              ),
            ),
          )),
    );
  }
}
