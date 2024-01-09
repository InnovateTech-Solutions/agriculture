import 'package:agriculture/src/auth_repo/user_repo.dart';
import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/login_controller.dart';
import 'package:agriculture/src/getx/user_controller.dart';
import 'package:agriculture/src/model/login_model.dart';
import 'package:agriculture/src/view/form_pages/register_page.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final userRepo = Get.put(UserRepository());

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.secScaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: controller.formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "LOGIN",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              letterSpacing: 2,
                              fontSize: 30,
                              color: ColorConst.mainScaffoldBackgroundColor,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FormWidget(
                        color: ColorConst.mainScaffoldBackgroundColor,
                        login: FormModel(
                            enableText: false,
                            hintText: "Email",
                            invisible: false,
                            validator: (phone) => controller.validEmail(phone),
                            type: TextInputType.name,
                            onChange: null,
                            inputFormat: null,
                            controller: controller.email)),
                    const SizedBox(
                      height: 50,
                    ),
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
                    const SizedBox(
                      height: 150,
                    ),
                    ButtonWidget(
                        textColor: ColorConst.secScaffoldBackgroundColor,
                        title: "Login",
                        onTap: () async {
                          controller.onLogin();
                          userRepo.getUserDetails(controller.email.text.trim());
                          UserController.instance.logIn();
                        },
                        containerColor: ColorConst.mainScaffoldBackgroundColor),
                    TextButton(
                      onPressed: () {
                        Get.to(const RegisterPage());
                      },
                      child: Text(
                        "Don't have account?Creat one",
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
      ),
    );
  }
}
