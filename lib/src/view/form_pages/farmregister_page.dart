import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/add_farm_controller.dart';
import 'package:agriculture/src/getx/register_controller.dart';
import 'package:agriculture/src/model/farm_model.dart';
import 'package:agriculture/src/model/login_model.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/farming_type.dart';
import 'package:agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/user_custom.dart/button.dart';

class FarmRegisterPage extends StatefulWidget {
  const FarmRegisterPage({super.key, required this.id});
  final String id;

  @override
  State<FarmRegisterPage> createState() => _FarmRegisterPageState();
}

class _FarmRegisterPageState extends State<FarmRegisterPage> {
  clearText() {
    controller.farmName.clear();
    controller.imageFile.clear();
    controller.farmName.clear();

    controller.farmAddress.clear();
    controller.area.clear();
    selectedContainers.clear();
    controller.idNumber.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    final registerCntroller = Get.put(AddFarmController());
    final controller = Get.put(RegisterController());

    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConst.mainScaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Form(
            key: registerCntroller.formkey,
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
                              registerCntroller.validName(farmName),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: registerCntroller.farmName)),
                  const SizedBox(height: 35),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "FARM ADDRESS *",
                          invisible: false,
                          validator: (farmAddress) =>
                              registerCntroller.validName(farmAddress),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: registerCntroller.farmAddress)),
                  const SizedBox(height: 35),
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
                            color: ColorConst.secScaffoldBackgroundColor,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    style: TextStyle(
                      color: ColorConst.secScaffoldBackgroundColor,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: ColorConst
                          .secScaffoldBackgroundColor, // Set your desired underline color here
                    ),
                    dropdownColor: ColorConst
                        .mainScaffoldBackgroundColor, // Set your desired dropdown menu color here
                    hint: Text(
                      'Select an area',
                      style: TextStyle(
                        color: ColorConst
                            .secScaffoldBackgroundColor, // Set your desired hint text color here
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  FormWidget(
                      ontap: () => addFarmingType(context),
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: true,
                          hintText: "type of crops*",
                          invisible: false,
                          validator: (type) =>
                              registerCntroller.validName(type),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: registerCntroller.typeOfFarming)),
                  const SizedBox(height: 35),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      ontap: () => registerCntroller.pickFarmImage(),
                      login: FormModel(
                          enableText: true,
                          hintText: "Farm Image*",
                          invisible: false,
                          validator: (type) =>
                              registerCntroller.validName(type),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: registerCntroller.imageFile)),
                  const SizedBox(height: 35),
                  ButtonWidget(
                      textColor: ColorConst.mainScaffoldBackgroundColor,
                      title: "Register",
                      onTap: () {
                        registerCntroller.addFarm(FarmModel(
                          image: registerCntroller.imageFile.text.trim(),
                          farmName: registerCntroller.farmName.text.trim(),
                          farmAddress:
                              registerCntroller.farmAddress.text.trim(),
                          farmArea: registerCntroller.area.text.trim(),
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
