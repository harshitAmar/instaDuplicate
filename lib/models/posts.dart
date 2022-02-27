import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String postUrl;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String profImage;
  final likes;
  Post({
    required this.description,
    required this.postUrl,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'postUrl': postUrl,
        'description': description,
        'postId': postId,
        'datePublished': datePublished,
        'profImage': profImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      datePublished: snapshot['datePublished'],
      description: snapshot['description'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
    );
  }
}
