import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as settings_fields;
import 'package:uber_clone/services/firebase/auth/uber_auth.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';

class UserSettingsService extends FirestoreService {


  Future<void> saveRideVerification() async {

    //first we check if there is already data - in case user is logging in again

    DocumentSnapshot data = await FirebaseFirestore.instance.collection('user_settings').doc(UberAuth.userId).get();

    if(data.exists)
      return;

     await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(FirestoreService.userSettings, {
        settings_fields.isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : false
      });
    });
  }

  Future<void> updateRideVerification({ required bool isUserUsingPIN, required bool isNightTimeOnly}) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(FirestoreService.userSettings, {
        settings_fields.isNightTimeOnly : isUserUsingPIN ? isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : isUserUsingPIN
      });
    });
  }




}