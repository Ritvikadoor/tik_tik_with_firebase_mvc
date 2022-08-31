import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  Future<String> uploadVideoToStorage(
      String id, String videoPath, final File vedioFile) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(vedioFile);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // compressVideo(String videoPath) async {
  //   log(videoPath);
  //   final compressedVideol = await VideoCompress.compressVideo(
  //     videoPath,
  //     quality: VideoQuality.MediumQuality,
  //     deleteOrigin: false,
  //   );

  //   log(compressedVideol.toString());

  //   return compressedVideol!.file;
  // }

  getThumbNail(String videoPath) async {
    final thumbNail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbNail;
  }

  Future<String> uploadImageToStorage(
    String id,
    String videoPath,
  ) async {
    Reference ref = firebaseStorage.ref().child('thumbnail').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbNail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songname, String caption, String videoPath,
      final File vedioFile) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videourl =
          await uploadVideoToStorage("Video $len", videoPath, vedioFile);
      String thumbnail = await uploadImageToStorage('Video $len', videoPath);

      Video video = Video(
        caption: caption,
        commentCount: 0,
        id: "Video $len",
        likes: [],
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        shareCount: 0,
        songname: songname,
        thumbnail: thumbnail,
        uid: uid,
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        videourl: videourl,
      );
      await firestore.collection('videos').doc("Video $len").set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
