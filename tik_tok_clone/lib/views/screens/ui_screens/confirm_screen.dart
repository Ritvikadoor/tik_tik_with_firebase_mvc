import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File vedioFile;

  final String vedioPath;

  const ConfirmScreen(
      {Key? key, required this.vedioFile, required this.vedioPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.vedioFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            height30,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            height30,
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
