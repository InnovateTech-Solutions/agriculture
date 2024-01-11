import 'package:agriculture/src/auth_repo/auth_repo.dart';
import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:agriculture/src/getx/report_controller.dart';
import 'package:agriculture/src/model/login_model.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_custom.dart/form_widget/form_widget.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key, required this.guideName});
  final String guideName;
  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final controller = Get.put(ReportController());
  final profileController = Get.put(ProfileController());
  final _authRepo = Get.put(AuthenticationRepository());

  void clearText() {
    controller.message.clear();
  }

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      IconButton(
                        color: ColorConst.iconColor,
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Text(
                        "Enter your message",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 18,
                              color: ColorConst.mainTextColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Write Your Message",
                          invisible: false,
                          validator: (message) => controller.validName(message),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.message)),
                  const SizedBox(
                    height: 50,
                  ),
                  const Spacer(),
                  ButtonWidget(
                    title: "Add",
                    onTap: () {
                      final email = _authRepo.firebaseUser.value?.email;
                      controller.addReport(ReportModel(
                          email: widget.guideName,
                          farmerName: email!,
                          message: controller.message.text.trim()));
                      clearText();
                    },
                    containerColor: ColorConst.secScaffoldBackgroundColor,
                    textColor: ColorConst.mainScaffoldBackgroundColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
