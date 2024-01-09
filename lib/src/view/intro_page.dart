import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/view/form_pages/login_page.dart';
import 'package:agriculture/src/view/form_pages/register_page.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.mainScaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                "AGRICULTURE Advisore",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: ColorConst.secScaffoldBackgroundColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                "Welcome to the future of farming with our agricultural app",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: ColorConst.secScaffoldBackgroundColor,
                  fontSize: 25,
                )),
              ),
              const SizedBox(
                height: 100,
              ),
              ButtonWidget(
                title: "Login",
                onTap: () {
                  Get.to(
                    const LoginPage(),
                  );
                },
                containerColor: ColorConst.secScaffoldBackgroundColor,
                textColor: ColorConst.mainScaffoldBackgroundColor,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                title: "Sign up",
                onTap: () {
                  Get.to(const RegisterPage());
                },
                containerColor: ColorConst.secScaffoldBackgroundColor,
                textColor: ColorConst.mainScaffoldBackgroundColor,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
