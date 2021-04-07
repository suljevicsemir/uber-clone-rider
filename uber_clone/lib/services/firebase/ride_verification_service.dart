import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as settings_fields;


class UserSettingsService  {


  Future<void> saveRideVerification() async {

    //first we check if there is already data - in case user is logging in again

    DocumentSnapshot data = await FirebaseFirestore.instance.collection('user_settings').doc(FirebaseAuth.instance.currentUser!.uid).get();

    if(data.exists)
      return;

     await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(FirebaseFirestore.instance.collection('user_settings').doc(FirebaseAuth.instance.currentUser!.uid), {
        settings_fields.isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : false
      });
    });
  }

  Future<void> updateRideVerification({ required bool isUserUsingPIN, required bool isNightTimeOnly}) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(FirebaseFirestore.instance.collection('user_settings').doc(FirebaseAuth.instance.currentUser!.uid), {
        settings_fields.isNightTimeOnly : isUserUsingPIN ? isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : isUserUsingPIN
      });
    });
  }




}