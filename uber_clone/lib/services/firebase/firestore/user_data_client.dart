import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_client.dart';
import 'package:uber_clone/services/secure_storage/user_data.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class UserDataClient extends FirestoreClient {

  final SecureStorage _secureStorage = SecureStorage();

  UserDataClient(): super();

  Future<FirestoreResult> syncUserData(UserData userData) async {
    try {
     DocumentSnapshot snapshot = await accountReference.get().timeout(const Duration(seconds: 3));
     if( snapshot.exists) {
       print('User already exists, not updating data.');
       return FirestoreResult(value: snapshot);
     }

     await instance.runTransaction((transaction) async{
       transaction.set(accountReference, {
         user_data_fields.firstName               : userData.firstName,
         user_data_fields.lastName                : userData.lastName,
         user_data_fields.profilePictureUrl       : userData.profilePictureUrl,
         user_data_fields.profilePictureTimestamp : Timestamp.now(),
         user_data_fields.signedInType            : userData.signedInType.parseSignedInType(),
         user_data_fields.providerUserId          : userData.providerUserId,
         user_data_fields.email                   : userData.email
       });
     }).timeout(const Duration(seconds: 3));

     return FirestoreResult(value: accountReference);
    }
    on TimeoutException catch(error) {
      return FirestoreResult(value: error);
    }
    on Exception catch(error) {
      return FirestoreResult(value: error);
    }
  }

  Future<FirestoreResult> loadUser() async {
    try {
      DocumentSnapshot snapshot = await accountReference.get();
      return FirestoreResult(value: UserData.fromFirestoreSnapshot(snapshot));
    }
    on TimeoutException catch (error) {
      return FirestoreResult(value: error);
    }
    on Exception catch (error) {
      return FirestoreResult(value: error);
    }
  }

  Future<FirestoreResult> updateFirstName({required String firstName}) async {
    try {
      await accountReference.update({
        user_data_fields.firstName : firstName
      });

      await _secureStorage.updateFirstName(firstName: firstName);

      return FirestoreResult(value: accountReference);
    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch (value) {
      return FirestoreResult(value: value);
    }
  }

  Future<FirestoreResult> updateLastName({required String lastName}) async {
    try {
      await accountReference.update({
        user_data_fields.lastName : lastName
      });

      await _secureStorage.updateLastName(lastName: lastName);

      return FirestoreResult(value: accountReference);
    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch (value) {
      return FirestoreResult(value: value);
    }
  }

  Future<FirestoreResult> updateEmail({required String email}) async {
    try {
      await accountReference.update({
        user_data_fields.email : email
      });

      await _secureStorage.updateEmail(email: email);

      return FirestoreResult(value: accountReference);
    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch (value) {
      return FirestoreResult(value: value);
    }
  }

  Future<FirestoreResult> updateProfilePictureUrl({required String profilePictureUrl}) async {
    try {
      await accountReference.update({
        user_data_fields.profilePictureUrl : profilePictureUrl
      });

      await _secureStorage.updateProfilePictureUrl(profilePictureUrl: profilePictureUrl);

      return FirestoreResult(value: accountReference);

    }
    on TimeoutException catch (value) {
      return FirestoreResult(value: value);
    }
    on Exception catch (value) {
      return FirestoreResult(value: value);
    }

  }


}