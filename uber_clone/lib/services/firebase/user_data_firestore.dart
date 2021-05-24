import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class UserDataFirestore {


  Future<bool> saveUser(UserData userData) async {
    try {

      DocumentSnapshot x = await FirebaseFirestore.instance.collection('users').doc(userData.firebaseUserId).get();
      if(x.exists)
        return true;


      await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(FirebaseFirestore.instance.collection('users').doc(userData.firebaseUserId), {
            user_data_fields.firstName : userData.firstName,
            user_data_fields.lastName : userData.lastName,
            //user_data_fields.profilePicture: userData.profilePictureUrl,
            user_data_fields.signedInType : userData.signedInType.parseSignedInType(),
            user_data_fields.providerUserId : userData.providerUserId,
            user_data_fields.email: userData.email
          });
      });
      return true;
    }
    catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<UserData?> loadUser() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      return UserData.fromFirestoreSnapshot(snapshot);
    }
    catch(err) {
      print(err.toString());
      return null;
    }
  }

  Future<bool> userExists() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      return snapshot.exists;
    }
    catch(err) {
      print('there was an error');
      return false;
    }
  }




}