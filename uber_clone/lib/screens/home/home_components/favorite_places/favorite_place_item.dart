import 'package:flutter/material.dart';
import 'package:uber_clone/screens/favorites_search/where_to_search.dart';

class FavoritePlaceItem extends StatelessWidget {

  final String favoritePlace, location;
  FavoritePlaceItem({required this.favoritePlace, required this.location});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, FavoritePlaceSearch.route, arguments: location),
      splashColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                height: 40,
                width: 40,
                color: Colors.grey[300],
                child: const Icon(Icons.location_on, color: Colors.black,),
              ),
            ),
            SizedBox(width: 30,),
            Text(favoritePlace, style: TextStyle(fontSize: 20, letterSpacing: 0.7, fontFamily: 'OnePlusSans'),),
            Spacer(),
            const Icon(Icons.keyboard_arrow_right)
          ],
        )
      ),
    );
  }
}
