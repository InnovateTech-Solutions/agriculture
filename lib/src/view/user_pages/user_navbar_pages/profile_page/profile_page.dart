import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:agriculture/src/getx/user_controller.dart';
import 'package:agriculture/src/model/user_model.dart';
import 'package:agriculture/src/view/form_pages/add_farm_page.dart';
import 'package:agriculture/src/view/intro_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/profile_page/weekly_report.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final auth = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConst.mainScaffoldBackgroundColor,
            body: FutureBuilder(
                future: controller.getUserDataForFarmer(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      UserModel userData = snapShot.data as UserModel;

                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(UserController.instance.farmName.value),
                                  Text(
                                    "Profile",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConst
                                                .secScaffoldBackgroundColor)),
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        await auth.signOut();

                                        Get.offAll(const IntroPage());
                                      },
                                      child: Icon(
                                        Icons.logout,
                                        color: ColorConst.iconColor,
                                      )),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: ColorConst.iconColor,
                              ),
                              headerText("Farmer Name: ${userData.name}"),
                              secText("Farmer Address: ${userData.address}"),
                              secText("Farmer Id Number: ${userData.idNumber}"),
                              Row(
                                children: [
                                  headerText("My Weekly Report"),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(AdminWeeklyReportView(
                                        farmerId: userData.idNumber,
                                      ));
                                    },
                                    icon: const Icon(Icons.article_outlined),
                                    color: ColorConst.iconColor,
                                  ),
                                  const Spacer(),
                                  FloatingActionButton(
                                    backgroundColor:
                                        ColorConst.secScaffoldBackgroundColor,
                                    onPressed: () {
                                      Get.to(
                                          AddFarmPage(id: userData.idNumber));
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: ColorConst
                                          .mainScaffoldBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 600,
                                width: double.infinity,
                                child: ProfileWidget(
                                  idNumber: userData.idNumber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapShot.hasError) {
                      return Center(child: Text('Error${snapShot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
