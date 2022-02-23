import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String photoUrl;
  final String uid;
  final String userName;
  final String bio;
  final List followers;
  final List following;
  User({
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': userName,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        photoUrl: snapshot['photoUrl'],
        uid: snapshot['uid'],
        userName: snapshot['username'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
