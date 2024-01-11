//when farmer is login and add farm

import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/add_farm_controller.dart';
import 'package:agriculture/src/model/farm_model.dart';
import 'package:agriculture/src/model/login_model.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/farming_type.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/user_custom.dart/button.dart';

class AddFarmPage extends StatefulWidget {
  const AddFarmPage({super.key, required this.id});
  final String id;

  @override
  State<AddFarmPage> createState() => _AddFarmPageState();
}

class _AddFarmPageState extends State<AddFarmPage> {
  clearText() {
    controller.farmName.clear();
    controller.imageFile.clear();
    controller.farmName.clear();
    controller.typeOfFarming.clear();

    controller.farmAddress.clear();
    controller.area.clear();
    selectedContainers.clear();
    controller.idNumber.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddFarmController());

    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConst.mainScaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Form(
            key: controller.formkey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    "Add your farm",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            letterSpacing: 2,
                            fontSize: 35,
                            color: ColorConst.secScaffoldBackgroundColor,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "FARM NAME *",
                          invisible: false,
                          validator: (farmName) =>
                              controller.validName(farmName),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.farmName)),
                  const SizedBox(height: 35),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "FARM ADDRESS *",
                          invisible: false,
                          validator: (farmAddress) =>
                              controller.validName(farmAddress),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.farmAddress)),
                  const SizedBox(height: 35),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "FARM Area *",
                          invisible: false,
                          validator: (farmArea) =>
                              controller.validName(farmArea),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.area)),
                  const SizedBox(height: 35),
                  FormWidget(
                      ontap: () => addFarmingType(context),
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: true,
                          hintText: "type of crops*",
                          invisible: false,
                          validator: (type) => controller.validName(type),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.typeOfFarming)),
                  const SizedBox(height: 35),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      ontap: () => controller.pickFarmImage(),
                      login: FormModel(
                          enableText: true,
                          hintText: "Farm Image*",
                          invisible: false,
                          validator: (type) => controller.validName(type),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.imageFile)),
                  const SizedBox(height: 35),
                  ButtonWidget(
                      textColor: ColorConst.mainScaffoldBackgroundColor,
                      title: "Register",
                      onTap: () {
                        controller.addFarm(FarmModel(
                          image: controller.imageFile.text.trim(),
                          farmName: controller.farmName.text.trim(),
                          farmAddress: controller.farmAddress.text.trim(),
                          farmArea: controller.area.text.trim(),
                          farmingType: selectedContainers,
                          idNumber: widget.id,
                        ));
                        clearText();
                      },
                      containerColor: ColorConst.secScaffoldBackgroundColor),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
