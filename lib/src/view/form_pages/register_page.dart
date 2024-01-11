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
                  DropdownButton<String>(
                    value: controller.selectedArea,
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedArea = newValue!;
                      });
                    },
                    items: controller.areas
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: ColorConst.mainScaffoldBackgroundColor,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    style: TextStyle(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: ColorConst
                          .mainScaffoldBackgroundColor, // Set your desired underline color here
                    ),
                    dropdownColor: ColorConst
                        .secScaffoldBackgroundColor, // Set your desired dropdown menu color here
                    hint: Text(
                      'Select an area',
                      style: TextStyle(
                        color: Colors
                            .white, // Set your desired hint text color here
                      ),
                    ),
                  ),
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
                                address: controller.selectedArea,
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
