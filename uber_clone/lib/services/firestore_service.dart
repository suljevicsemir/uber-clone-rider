import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/globals.dart' as globals;
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
class FirestoreService {

   static final FirebaseFirestore _instance = FirebaseFirestore.instance;
   static final _users = FirebaseFirestore.instance.collection('users');

   static Future<bool> saveUser(UserData userData) async {

       print("ovdje je " + userData.signedInType.parseSignedInType());
        try {
            await _instance.runTransaction((transaction) async {
                transaction.set(_users.doc(userData.firebaseUserId), {
                    globals.firstName : userData.firstName,
                    globals.lastName : userData.lastName,
                    globals.profilePicture: userData.profilePicture,
                    globals.phoneNumber: userData.phoneNumber,
                    globals.signedInType : userData.signedInType.parseSignedInType(),
                    globals.providerUserId : userData.providerUserId,
                    globals.email: userData.email
                });
            });
            return true;
        }
        catch (err) {
            print(err.toString());
            return false;
        }
    }


}