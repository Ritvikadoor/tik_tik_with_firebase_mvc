import 'package:flutter/material.dart';
import 'package:tik_tok_clone/views/sample.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  VideoPlayerItem({Key? key, required this.videourl}) : super(key: key);
  final String videourl;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videourl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: VideoPlayer(videoPlayerController),
    );
  }
}
