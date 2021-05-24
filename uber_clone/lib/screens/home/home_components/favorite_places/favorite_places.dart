

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/favorite_places_display.dart';
import 'package:uber_clone/screens/home/home_components/favorite_places/loading_shimmer.dart';

class HomeFavoritePlaces extends StatefulWidget {
  @override
  _HomeFavoritePlacesState createState() => _HomeFavoritePlacesState();
}

class _HomeFavoritePlacesState extends State<HomeFavoritePlaces> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300,
      left: 0,
      right: 0,
      child: Column(
        children: [
          !Provider.of<FavoritePlacesProvider>(context).haveLoaded ?
          LoadingShimmer() :
          FavoritePlacesDisplay()

        ],
      )
    );
  }
}
