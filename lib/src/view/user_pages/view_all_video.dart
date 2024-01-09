import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/video_controller.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViewViedo extends StatefulWidget {
  const ViewViedo({super.key});

  @override
  State<ViewViedo> createState() => _ViewViedoState();
}

class _ViewViedoState extends State<ViewViedo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController());

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.fetchVideo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final video = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            color: ColorConst.iconColor,
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          headerText("Video that may help you"),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 700,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: video.length,
                          itemBuilder: (context, index) {
                            final videoTitle = video[index]['Title'];

                            final videoId = video[index]['VideoId'];

                            return Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                        initialVideoId: videoId,
                                        flags: const YoutubePlayerFlags(
                                            autoPlay: false,
                                            mute: true,
                                            isLive: false)),
                                    showVideoProgressIndicator: true,
                                    progressIndicatorColor:
                                        ColorConst.iconColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                secText(shortenText(videoTitle))
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  String shortenText(String text, {int maxLength = 30}) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
