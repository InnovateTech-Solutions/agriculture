import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/farm_controller.dart';
import 'package:agriculture/src/model/farm_model.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:agriculture/src/widget/user_custom.dart/other_farm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmPage extends StatelessWidget {
  const FarmPage({super.key, required this.farmModel});
  final FarmModel farmModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmController());

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: ColorConst.iconColor,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: FutureBuilder(
                future: controller.fetchFarmById(farmModel.farmName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 350,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(farmModel.image),
                                        fit: BoxFit.cover)),
                                child: Image.network(
                                  farmModel.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            headerText(farmModel.farmName),
                            secText(farmModel.farmArea),
                            secText(farmModel.farmAddress),
                            const SizedBox(
                              height: 50,
                            ),
                            headerText("Type of crops"),
                            Divider(
                              thickness: 3,
                              color: ColorConst.iconColor,
                            ),
                            SizedBox(
                              height: 100,
                              width: 350,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: farmModel.farmingType.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 150,
                                      height: 80,
                                      margin: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: ColorConst
                                              .secScaffoldBackgroundColor),
                                      child: Center(
                                        child: Text(
                                          farmModel.farmingType[index],
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: ColorConst
                                                      .mainScaffoldBackgroundColor)),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            headerText("Other Farm"),
                            Divider(
                              thickness: 3,
                              color: ColorConst.iconColor,
                            ),
                            const OtherFarmWidget(),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error${snapshot.error}'));
                    } else {
                      return const Text("something went wrong");
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Text("something went wrong");
                  }
                })));
  }
}
