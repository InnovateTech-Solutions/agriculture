import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/getx/video_controller.dart';
import 'package:agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
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
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
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
                            progressIndicatorColor: ColorConst.iconColor,
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
                      width: 20,
                    );
                  },
                ),
              ),
            ],
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
