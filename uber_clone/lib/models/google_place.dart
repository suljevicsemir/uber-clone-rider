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



}