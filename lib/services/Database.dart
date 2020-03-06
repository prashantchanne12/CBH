import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cd/modal/user.dart';
import 'package:cd/modal/details.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUserData(
      String name,
      String email,
      String profilepic,
      String date,
      String selectedStream,
      String selectedClass,
      String interest) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'email': email,
      'profilepic': profilepic,
      'uid': uid,
      'date': date,
      'lastClass': selectedClass,
      'hscStream': selectedStream,
      'interest': interest
    });
  }

  // //getting data from snapshot
  List<Details> _usersFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Details(
          uid: doc.data['uid'],
          name: doc.data['name'],
          email: doc.data['email'],
          profilepic: doc.data['profilepic'],
          date: doc.data['date'],
          interest: doc.data['interest'],
          lastClass: doc.data['lastClass'],
          selectedStream: doc.data['hscStream']);
    }).toList();
  }

  //getting data from user

  Stream<List<Details>> get details {
    return userCollection
        .orderBy('date', descending: true)
        .snapshots()
        .map(_usersFromSnapshot);
  }

  UserName _userNameFromSnapshot(DocumentSnapshot snapshot) {
    return UserName(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      profilepic: snapshot.data['profilepic'],
      date: snapshot.data['date'],
      lastClass: snapshot.data['lastClass'],
      interest: snapshot.data['interest'],
      lastStream: snapshot.data['hseStream'],
    );
  }

  Stream<UserName> get userName {
    return userCollection.document(uid).snapshots().map(_userNameFromSnapshot);
  }
}
