import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/register_controller.dart';
import 'package:agriculture/src/model/login_model.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:agriculture/src/view/form_pages/login_page.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConst.secScaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: controller.formkey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "REGISTER",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            letterSpacing: 2,
                            fontSize: 30,
                            color: ColorConst.mainScaffoldBackgroundColor,
                            fontWeight: FontWeight.w500)),
                  ),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "NAME",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.name)),
                  const SizedBox(height: 40),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "EMAIL",
                          invisible: false,
                          validator: (email) => controller.validEmail(email),
                          type: TextInputType.emailAddress,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.email)),
                  const SizedBox(height: 40),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "FARMER ID NUMBER",
                          invisible: false,
                          validator: (id) => controller.validIdNumber(id),
                          type: TextInputType.number,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.idNumber)),
                  const SizedBox(height: 40),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "ADDRESS",
                          invisible: false,
                          validator: (address) =>
                              controller.validAddress(address),
                          type: TextInputType.text,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.address)),
                  const SizedBox(height: 40),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "PASSWORD",
                          invisible: true,
                          validator: (password) =>
                              controller.vaildatePassword(password),
                          type: TextInputType.visiblePassword,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.password)),
                  const SizedBox(height: 40),
                  FormWidget(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "CONFIRM PASSWORD",
                          invisible: true,
                          validator: (password) =>
                              controller.vaildateConfirmPassword(password),
                          type: TextInputType.visiblePassword,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.confirmPassword)),
                  const SizedBox(height: 40),
                  ButtonWidget(
                      textColor: ColorConst.secScaffoldBackgroundColor,
                      title: "Register",
                      onTap: () {
                        controller.onSignup(
                            UserModel(
                                userType: "Farmer",
                                name: controller.name.text,
                                email: controller.email.text,
                                idNumber: controller.idNumber.text,
                                address: controller.address.text,
                                password: controller.password.text),
                            context);
                      },
                      containerColor: ColorConst.mainScaffoldBackgroundColor),
                  TextButton(
                    onPressed: () {
                      Get.to(const LoginPage());
                    },
                    child: Text(
                      "Already have account?Login",
                      style: TextStyle(
                          color: ColorConst.mainScaffoldBackgroundColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
