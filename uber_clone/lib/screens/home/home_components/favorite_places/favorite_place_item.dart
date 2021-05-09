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
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                height: 45,
                width: 45,
                color: Colors.grey,
                child: const Icon(Icons.location_on, color: Colors.white,),
              ),
            ),
            SizedBox(width: 20,),
            Text(favoritePlace, style: TextStyle(fontSize: 20, letterSpacing: 0.7, fontFamily: 'OnePlusSans'),),
            Spacer(),
            const Icon(Icons.keyboard_arrow_right)
          ],
        )
      ),
    );
  }
}
