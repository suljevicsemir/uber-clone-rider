


import 'package:flutter/material.dart';
import 'package:uber_clone/screens/favorites_search/where_to_search.dart';

class FavoritePlaceBanner extends StatelessWidget {

  final String location;

  FavoritePlaceBanner({required this.location});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, FavoritePlaceSearch.route, arguments: location),
      splashColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            location == 'home' ?
            const Icon(Icons.home, color: Colors.black,) : const Icon(Icons.work, color: Colors.black,),
            SizedBox(width: 15),
            location == 'home' ? Text('Add a home location', style: TextStyle(fontSize: 18),)
            : Text('Add a work location', style: TextStyle(fontSize: 18),),

          ],
        ),
      ),
    );
  }
}
