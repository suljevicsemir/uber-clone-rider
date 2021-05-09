import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/models/google_place.dart';
import 'package:uber_clone/providers/internet_connectivity_provider.dart';
import 'package:uber_clone/providers/settings/account_settings.dart';


class GooglePlaceItem extends StatelessWidget {

  final GooglePlace place;
  final String type;

  GooglePlaceItem({required this.place, required this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //await Provider.of<SearchProvider>(context, listen: false).setPlace(place);
        if(Provider.of<ConnectivityProvider>(context, listen: false).isConnected()) {
          await Provider.of<FavoritePlacesProvider>(context, listen: false).setPlace(place, type);
          Navigator.pop(context);
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Unable to update data, no internet connection!', style: TextStyle(fontSize: 20, color: Colors.white),)),
                )
              ],
            ),
          ));
        }

      },
      splashColor: Colors.grey[800],
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5)
            )
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(place.placeName, style: TextStyle(color: Colors.black),),
                SizedBox(height: 5,),
                place.state.isEmpty ? Text(place.country, style: TextStyle(color: Colors.grey[600]),) : Text(place.state + ', ' + place.country, style: TextStyle(color: Colors.grey[600]),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
