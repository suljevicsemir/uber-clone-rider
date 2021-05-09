

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_clone/models/google_place.dart';

class FavoritePlacesProvider extends ChangeNotifier {

  GooglePlace? home, work;
  List<GooglePlace>? savedPlaces = [];

  bool haveLoaded = false;


  FavoritePlacesProvider() {
    loadFavoritePlaces();
    print('loading favorite places');
  }

  Future<void> loadFavoritePlaces() async {

    if(FirebaseAuth.instance.currentUser == null)
      return;

    Timer(const Duration(milliseconds: 3200), () async{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('account_settings').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').get();

      List<QueryDocumentSnapshot> list = snapshot.docs;

      for(int i = 0; i < list.length; i++) {
        if(list.elementAt(i).metadata.isFromCache)
          print('cache bato');
        if( list.elementAt(i).id == 'home') {
          home = GooglePlace.fromSnapshot(list.elementAt(i));
        }
        else if(list.elementAt(i).id == 'work') {
          work = GooglePlace.fromSnapshot(list.elementAt(i));
        }
        else {
          savedPlaces!.add(GooglePlace.fromSnapshot(list.elementAt(i)));
        }
      }
      haveLoaded = true;
      notifyListeners();
    });



  }

  Future<void> setPlace(GooglePlace place, String type) async {
    if( type == 'home')
      home = place;
    if( type == 'work')
      work = place;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(FirebaseFirestore.instance.collection('account_settings').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites').doc(type), {
        'country' : place.country,
        'placeName': place.placeName,
        'state': place.state
      });
    });
    notifyListeners();
  }
}