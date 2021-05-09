

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';

class HomeFavoritePlaces extends StatefulWidget {
  @override
  _HomeFavoritePlacesState createState() => _HomeFavoritePlacesState();
}

class _HomeFavoritePlacesState extends State<HomeFavoritePlaces> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 350,
      left: 20,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            !Provider.of<FavoritePlacesProvider>(context).haveLoaded ?
            Shimmer.fromColors(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 40,),
                      const SizedBox(width: 30,),
                      Container(
                        height: 30,
                        width: 90,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_right, size: 40,)
                      ],
                    ),
                  Divider(
                    indent: 70,
                    height: 40,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 40,),
                      const SizedBox(width: 30,),
                      Container(
                        height: 30,
                        width: 90,
                        color: Colors.grey,
                      ),
                      Spacer(),
                      const Icon(Icons.keyboard_arrow_right, size: 40,)
                    ],
                  )
                ],
              ),

              baseColor: Colors.black12,
              highlightColor: Colors.white,
            ) :
            Provider.of<FavoritePlacesProvider>(context).home != null ?
            Row(
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
                Text(Provider.of<FavoritePlacesProvider>(context, listen: false).home!.placeName, style: TextStyle(fontSize: 20, letterSpacing: 0.7, fontFamily: 'OnePlusSans'),),
                Spacer(),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Set a home location for easy access')
              ],
            ),
            Divider(
              indent: 70,
              height: 30,
              color: Colors.grey,
              thickness: 1,
            ),
            Provider.of<FavoritePlacesProvider>(context).work != null ?
            Row(
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
                Text(Provider.of<FavoritePlacesProvider>(context, listen: false).home!.placeName, style: TextStyle(fontSize: 20, letterSpacing: 0.7, fontFamily: 'OnePlusSans'),),
                Spacer(),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Set a work location for easy access')
              ],
            ),

          ],
        ),
      )
    );
  }
}
