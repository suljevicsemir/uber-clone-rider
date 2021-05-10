

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/favorite_place_banner.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/favorite_place_item.dart';

class FavoritePlacesDisplay extends StatefulWidget {
  @override
  _FavoritePlacesDisplayState createState() => _FavoritePlacesDisplayState();
}

class _FavoritePlacesDisplayState extends State<FavoritePlacesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Provider.of<FavoritePlacesProvider>(context).home != null ?
        FavoritePlaceItem(favoritePlace: Provider.of<FavoritePlacesProvider>(context, listen: false).home!.placeName, location: 'home',) :
        FavoritePlaceBanner(location: 'home'),
        Divider(
          indent: 70,
          height: 35,
          color: Colors.grey,
          thickness: 1,
        ),
        Provider.of<FavoritePlacesProvider>(context).work != null ?
        FavoritePlaceItem(favoritePlace: Provider.of<FavoritePlacesProvider>(context, listen: false).work!.placeName, location: 'work',) :
        FavoritePlaceBanner(location: 'work')
      ],
    );
  }
}
