import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/controller/upload_video_controller.dart';
import 'package:tik_tok_clone/views/widgets/text_input.dart';
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
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
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
  void dispose() {
    controller.dispose();

    super.dispose();
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
                      child: TextInputScreen(
                        controller: songController,
                        labelText: 'Song Name',
                        icon: Icons.music_note,
                      ),
                    ),
                    height25,
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextInputScreen(
                          controller: captionController,
                          labelText: 'Caption',
                          icon: Icons.closed_caption),
                    ),
                    height25,
                    ElevatedButton(
                        onPressed: () {
                          log("Video file ${widget.vedioFile}");
                          log("Video path ${widget.vedioPath}");
                          uploadVideoController.uploadVideo(
                            songController.text,
                            captionController.text,
                            widget.vedioPath,
                            widget.vedioFile,
                          );
                        },
                        child: const Text(
                          'Share',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
