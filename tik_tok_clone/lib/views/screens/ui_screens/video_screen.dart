import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/controller/video_controller.dart';
import 'package:tik_tok_clone/views/widgets/circle_animation.dart';
import 'package:tik_tok_clone/views/widgets/video_player_items.dart';

class VedioScreen extends StatelessWidget {
  VedioScreen({Key? key}) : super(key: key);
  final VideoControllerX videoControllerX = Get.put(VideoControllerX());

  buildProfile(String profilePic) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePic),
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoControllerX.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(
                    videourl: data.videourl,
                  ),
                  Column(
                    children: [
                      height100,
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: whiteColor,
                                        ),
                                        Text(
                                          'Song name ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 450,
                              width: 100,
                              margin: EdgeInsets.only(top: size.width / 5),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildProfile(''),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.favorite,
                                              size: 40,
                                              color: buttonColor,
                                            ),
                                          ),
                                          const Text(
                                            '2200 likes ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: whiteColor,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.comment,
                                              size: 40,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const Text(
                                            '1000 ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: whiteColor,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.share,
                                              size: 40,
                                              color: whiteColor,
                                            ),
                                          ),
                                          const Text(
                                            '1000 ',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: whiteColor,
                                            ),
                                          ),
                                          CircleAnimation(
                                              child: buildMusicAlbum(
                                                  'Profile Photo'))
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            });
      }),
    );
  }
}
