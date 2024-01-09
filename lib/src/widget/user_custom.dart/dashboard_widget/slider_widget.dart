import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/ads_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final adsController = Get.put(AdsController());
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: adsController.fetchAds(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading ads'));
        } else {
          List<Map<String, dynamic>> ads = snapshot.data!;
          return Column(
            children: [
              CarouselSlider(
                items: ads.map((ad) {
                  return Container(
                    width: 350,
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: ColorConst.secScaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ad['image']),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  height: 200.0,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
