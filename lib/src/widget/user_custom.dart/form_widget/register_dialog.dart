import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/view/form_pages/farmregister_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/navbar_page.dart';
import 'package:agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void addFarmDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
            height: 150,
            width: 200,
            child: Column(
              children: [
                Text(
                  "Interested in registering your farm?",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 18, color: ColorConst.mainTextColor),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ButtonWidget(
                          title: "Yes",
                          onTap: () {
                            Get.to(FarmRegisterPage(
                              id: id,
                            ));
                          },
                          containerColor: ColorConst.secScaffoldBackgroundColor,
                          textColor: ColorConst.mainScaffoldBackgroundColor),
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ButtonWidget(
                          title: "No",
                          onTap: () {
                            Get.offAll(const NavBarWidget());
                          },
                          containerColor: ColorConst.secScaffoldBackgroundColor,
                          textColor: ColorConst.mainScaffoldBackgroundColor),
                    ),
                  ],
                )
              ],
            )),
      );
    },
  );
}
