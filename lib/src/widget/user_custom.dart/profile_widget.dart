import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/profile_controller.dart';
import 'package:agriculture/src/model/farm_model.dart';
import 'package:agriculture/src/view/user_pages/view_farm_page.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.idNumber});
  final String idNumber;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: FutureBuilder(
          future: controller.fetchAllFarm(idNumber),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              if (snapShot.hasData) {
                final farm = snapShot.data!;
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      headerText("My Farms"),
                      Divider(
                        thickness: 2,
                        color: ColorConst.iconColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final farmName =
                                  farm[index]['FarmName'].toString();
                              final farmAddress =
                                  farm[index]['FarmAddress'].toString();
                              final farmArea =
                                  farm[index]['FarmsArea'].toString();
                              final farmId = farm[index]['IdNumber'].toString();
                              final farmingType =
                                  List<String>.from(farm[index]['FarmingType']);
                              final image = farm[index]['Image'];

                              return GestureDetector(
                                onTap: () {
                                  Get.to(FarmPage(
                                      farmModel: FarmModel(
                                          farmName: farmName,
                                          farmAddress: farmAddress,
                                          farmArea: farmArea,
                                          farmingType: farmingType,
                                          idNumber: idNumber,
                                          image: image)));
                                },
                                child: Container(
                                  height: 120,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorConst.mainScaffoldBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(.2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          ColorConst.secScaffoldBackgroundColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        headerText(farmName),
                                        secText(farmAddress),
                                        secText(farmArea),
                                        secText(farmId),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: farm.length),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                );
              } else if (snapShot.hasError) {
                return Center(child: Text('Error${snapShot.error}'));
              } else {
                return const Text("somthing went wrong");
              }
            } else if (snapShot.connectionState == ConnectionState.waiting) {
              return const Text("somthing went wrong");
            } else {
              return const Text("somthing went wrong");
            }
          }),
    );
  }
}
