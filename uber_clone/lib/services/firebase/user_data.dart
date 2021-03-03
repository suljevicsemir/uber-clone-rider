import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class UserDataFirestore extends FirestoreService {


  Future<bool> saveUser(UserData userData) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(super.user, {
            user_data_fields.firstName : userData.firstName,
            user_data_fields.lastName : userData.lastName,
            user_data_fields.profilePicture: userData.profilePicture,
            user_data_fields.phoneNumber: userData.phoneNumber,
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

  Future<UserData> loadUser() async {
    try {
      DocumentSnapshot snapshot = await super.user.get();
      return UserData.fromFirestoreSnapshot(snapshot);
    }
    catch(err) {
      print(err.toString());
      return null;
    }
  }




}