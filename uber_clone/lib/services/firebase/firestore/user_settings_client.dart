

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as settings_fields;
import 'package:uber_clone/models/firestore_result.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_client.dart';

class UserSettingsClient extends FirestoreClient {


  Future<FirestoreResult> createSettings() async {

    try {
      print('Before creating settings');


      DocumentSnapshot data = await accountSettingsReference
          .get()
          .timeout(const Duration(seconds: 3));




      if ( data.exists) {
        print("Account settings already exist, will not be overwritten");
        return FirestoreResult(value: data);
      }

      print('BEFORE SETTING');
      await instance.runTransaction((transaction) async {
        transaction.set(accountSettingsReference, {
          settings_fields.isNightTimeOnly : false,
          settings_fields.isUserUsingPIN  : false
        });

      });



      print('AFTER SETTING');

      return FirestoreResult(value: data );
    }
    on TimeoutException catch (error) {
      return FirestoreResult(value: error);
    }
    on Exception catch (error) {
      return FirestoreResult(value: error);
    }

  }

  Future<FirestoreResult> updateRideVerification({required bool isUserUsingPin, required bool isNightTimeOnly}) async {
   try {
     await instance.runTransaction((transaction) async{
       transaction.update(accountSettingsReference, {
         settings_fields.isNightTimeOnly : isUserUsingPin ? isNightTimeOnly : false,
         settings_fields.isUserUsingPIN  : isUserUsingPin
       });
     });
     return FirestoreResult(value: accountSettingsReference);
   }
   on TimeoutException catch (error) {
    return FirestoreResult(value: error);
   }
   on Exception catch (error) {
    return FirestoreResult(value: error);
   }
  }


}