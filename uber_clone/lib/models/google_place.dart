import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GooglePlace {
  final String placeName, state, country;

  GooglePlace({required this.placeName, required this.state, required this.country});

  factory GooglePlace.fromDescription(String description) {

   final List<String> components = description.split(', ');

   if(components.length > 2) {
     return GooglePlace(placeName: components.elementAt(0), state: components.elementAt(1), country: components.elementAt(2));
   }

   if(components.length == 2) {
     return GooglePlace(placeName: components.elementAt(0), country: components.elementAt(1), state: '');
   }

   return GooglePlace(placeName: components.elementAt(0), state: '', country: '');


  }
  
  factory GooglePlace.fromSnapshot(QueryDocumentSnapshot snapshot) {
    String placeName = '', state = '', country = '';
    
    placeName = snapshot.get('placeName');
    if(snapshot.get('country') != null)
      country = snapshot.get('country');
    if(snapshot.get('state') != null)
      state = snapshot.get('state');

    return GooglePlace(placeName: placeName, state: state, country: country);
    
    
  }
  
  



}