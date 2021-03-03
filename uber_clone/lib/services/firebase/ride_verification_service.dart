import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as settings_fields;
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';

class UserSettingsService extends FirestoreService {


  Future<void> saveRideVerification() async {
     await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(FirestoreService.userSettings, {
        settings_fields.isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : false
      });
    });
  }

  Future<void> updateRideVerification({bool isUserUsingPIN, bool isNightTimeOnly}) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(FirestoreService.userSettings, {
        settings_fields.isNightTimeOnly : isUserUsingPIN ? isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : isUserUsingPIN
      });
    });
  }




}