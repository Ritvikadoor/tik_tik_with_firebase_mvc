import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songname;
  String caption;
  String videourl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.shareCount,
    required this.songname,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videourl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songname": songname,
        "caption": caption,
        "videourl": videourl,
        "thumbnail": thumbnail,
        "profilePhoto": profilePhoto,
      };
  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      caption: snapshot["caption"],
      commentCount: snapshot["commentCount"],
      id: snapshot["id"],
      likes: snapshot["likes"],
      profilePhoto: snapshot["profilePhoto"],
      shareCount: snapshot["shareCount"],
      songname: snapshot["songname"],
      thumbnail: snapshot["thumbnail"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      videourl: snapshot["videourl"],
    );
  }
}
