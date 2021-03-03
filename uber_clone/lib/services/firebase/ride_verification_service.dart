import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone/constants/user_settings/ride_verification.dart' as settings_fields;
import 'package:uber_clone/models/ride_verification.dart';
import 'package:uber_clone/services/firebase/firestore/firestore_service.dart';

class UserSettingsService extends FirestoreService {

  UserSettingsService(): super();

  Future<RideVerification> loadVerificationSettings() async {
    DocumentSnapshot rideVerificationSettings = await super.userSettings.get();

    RideVerification rideVerification = RideVerification();

    rideVerification.isUserUsingPIN = rideVerification.initialUsingPIN = rideVerificationSettings.get(settings_fields.isUserUsingPIN);

    if(rideVerification.isUserUsingPIN) {
      rideVerification.isNightTimeOnly = rideVerification.initialNightTime = rideVerificationSettings.get(settings_fields.isNightTimeOnly);
    }

    return rideVerification;
  }

  Future<void> saveRideVerification() async {
     await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(super.userSettings, {
        settings_fields.isNightTimeOnly : false,
        settings_fields.isUserUsingPIN  : false
      });
    });
  }

  Future<void> updateRideVerification({bool isUserUsingPIN, bool isNightTimeOnly}) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(super.userSettings, {
        settings_fields.isNightTimeOnly : isUserUsingPIN,
        settings_fields.isUserUsingPIN  : isNightTimeOnly
      });
    });
  }




}