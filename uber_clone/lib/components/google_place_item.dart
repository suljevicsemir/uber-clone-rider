import 'package:flutter/material.dart';
import 'package:uber_clone/models/google_place.dart';


class GooglePlaceItem extends StatelessWidget {

  final GooglePlace place;


  GooglePlaceItem({required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5)
          )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle
            ),
            child: SizedBox(
              height: 45,
              width: 45,
              child: Icon(Icons.location_on, color: Colors.white,),
            ),
          ),
          SizedBox(width: 30,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(place.placeName, style: TextStyle(color: Colors.black),),
                SizedBox(height: 5,),
                place.state.isEmpty ? Text(place.country, style: TextStyle(color: Colors.grey[600],), overflow: TextOverflow.ellipsis,)
                : Text(place.state + ', ' + place.country, style: TextStyle(color: Colors.grey[600]), overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
