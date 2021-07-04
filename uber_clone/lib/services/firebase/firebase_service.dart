

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {



  static FirebaseAuth get authInstance {
    return FirebaseAuth.instance;
  }

  static FirebaseFirestore get firestoreInstance {
    return FirebaseFirestore.instance;
  }

  static Reference get _storageReference {
    return FirebaseStorage.instance.ref();
  }

  static User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }




}