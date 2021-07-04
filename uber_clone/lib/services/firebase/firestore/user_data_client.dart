


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/models/signed_in_type.dart';
import 'package:uber_clone/models/user_data.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_client.dart';
import 'package:uber_clone/user_data_fields.dart' as user_data_fields;

class UserDataClient extends FirestoreClient {


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
         user_data_fields.firstName : userData.firstName,
         user_data_fields.lastName : userData.lastName,
         user_data_fields.profilePictureUrl: userData.profilePictureUrl,
         user_data_fields.signedInType : userData.signedInType.parseSignedInType(),
         user_data_fields.providerUserId : userData.providerUserId,
         user_data_fields.email: userData.email
       });
     });


     



     switch (result.value) {
       case DocumentSnapshot:
          if( !(result.value as DocumentSnapshot).exists) {
            _saveUserData(userData);
          }
         break;
       case TimeoutException:

         break;
       default:
     }
    }
    on TimeoutException catch(error) {
      return FirestoreResult(value: error);
    }
    on Exception catch(error) {
      return FirestoreResult(value: error);
    }
  }



  Future<FirestoreResult> _userExists() async {
    try {
      DocumentSnapshot snapshot = await accountReference.get().timeout(const Duration(seconds: 3));
      return FirestoreResult(value: snapshot);
    }
    on TimeoutException catch(error) {
      return FirestoreResult(value: error);
    }
    on Exception catch(error) {
      return FirestoreResult(value: error);
    }
  }

  Future<FirestoreResult> _saveUserData(UserData userData) async {
    try {
      await instance.runTransaction((transaction) async{
        transaction.set(accountReference, {
          user_data_fields.firstName : userData.firstName,
          user_data_fields.lastName : userData.lastName,
          //user_data_fields.profilePicture: userData.profilePictureUrl,
          user_data_fields.signedInType : userData.signedInType.parseSignedInType(),
          user_data_fields.providerUserId : userData.providerUserId,
          user_data_fields.email: userData.email
        });
      });
      return FirestoreResult(value: accountReference);
    }
    on TimeoutException catch (error) {
      return FirestoreResult(value: error);
    }
    on Exception catch ( error) {
      return FirestoreResult(value: error);
    }
  }
}