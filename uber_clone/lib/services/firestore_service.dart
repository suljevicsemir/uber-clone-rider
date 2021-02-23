import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;
class FirestoreService {

   static final FirebaseFirestore _instance = FirebaseFirestore.instance;
   static final _users = FirebaseFirestore.instance.collection('users');

   static Future<bool> saveUser(UserData userData) async {

        try {
            await _instance.runTransaction((transaction) async {
                transaction.set(_users.doc(userData.firebaseUserId), {
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


}