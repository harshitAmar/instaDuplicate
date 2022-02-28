// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/models/posts.dart';
import 'package:insta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStroreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some Error Occured";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToFireBaseStorage("posts", file, true);

      String postId = Uuid().v1();
      Post post = Post(
        description: description,
        postUrl: photoUrl,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
