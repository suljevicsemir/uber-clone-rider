

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart' as location;
import 'package:uber_clone/components/app_utils.dart' as app;
import 'package:uber_clone/components/google_place_item.dart';
import 'package:uber_clone/constants/api_key.dart' as api;
import 'package:uber_clone/models/google_place.dart';
import 'package:uber_clone/models/ride_request.dart';
import 'package:uuid/uuid.dart';

class Pickup extends StatefulWidget {

  static const String route = '/pickup';
  final DateTime dateTime;

  Pickup({required this.dateTime});

  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {


  location.Location tracker = location.Location();
  location.LocationData? locationData;
  geo.Placemark? placemark;
  late StreamSubscription subscription;
  late String formattedDate = "";
  String inputValue = '';
  final String token = Uuid().v4();
  final TextEditingController controller = TextEditingController();
  bool shouldSend = false;
  List<GooglePlace> places = [];
  int indexToSend = -1;


  GooglePlace? placeToSend;


  Future<void> getPlaces(String input) async {
    if (input.isEmpty) {
      setState(() {
        this.places.clear();
      });
      return;
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';

    String request = '$baseURL?input=$input&key=${api.apiKey}&type=$type&sessiontoken=$token&radius=10000&location=${locationData!.latitude},${locationData!.longitude}';
    Response response = await Dio().get(request);
    dynamic predictions = response.data['predictions'];

    List<GooglePlace> places = <GooglePlace>[];

    for(int i = 0; i < predictions.length; i++) {
      String description = predictions[i]['description'];
      print(predictions[i]);
      places.add(GooglePlace.fromDescription(description));
    }

    setState(() {
      this.places.clear();
      this.places = places;
    });


  }


  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    if(widget.dateTime.month == now.month && widget.dateTime.day == now.day) {
      formattedDate += "Today at " + app.getTime(widget.dateTime);
    }
    else {
      formattedDate +=
          app.getTime(widget.dateTime) + ", " + app.getDate(widget.dateTime);
    }

    {
      subscription = tracker.onLocationChanged.listen((location.LocationData data) async{

        if(placemark == null) {
          placemark = (await geo.placemarkFromCoordinates(data.latitude!, data.longitude!)).first;


          locationData = data;
          setState(() {

          });
          return;
        }
        if(geolocator.Geolocator.distanceBetween(data.latitude!, data.longitude!, locationData!.latitude!, locationData!.longitude!) > 5) {
          locationData = data;
          placemark = (await geo.placemarkFromCoordinates(data.latitude!, data.longitude!)).first;
          setState(() {

          });
        }
        print(placemark);
        subscription.cancel();
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    print('build is called');


    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Container(
                margin: EdgeInsets.only(left: 43, right: 20),
                width: MediaQuery.of(context).size.width - 70,
                color: const Color(0xffededed),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(formattedDate, style: TextStyle(fontSize: 18),),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 8,
                            width: 8,
                            color: Colors.grey[600],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 2,
                          color: Colors.black38,
                        ),
                        Container(
                          height: 8,
                          width: 8,
                          color: Colors.black87,
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width - 70,
                        color: const Color(0xffededed),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: placemark == null ? Text('Waiting for location...', style: TextStyle(fontSize: 18),) : Text( placemark!.street!, style: TextStyle(fontSize: 18),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width - 70,
                        child: TextField(
                          controller: controller,
                          onChanged: (String text) {

                              if(inputValue.compareTo(text) != 0 || !shouldSend) {
                                getPlaces(text);
                                inputValue = text;
                                if(shouldSend)
                                  shouldSend = false;
                              }
                          },
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.teal.shade800,
                          cursorHeight: 24,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: 'Where to?',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                if (inputValue.compareTo('') == 0)
                                  return;
                                controller.clear();
                                inputValue = '';
                                places.clear();
                                setState(() {

                                });
                              },
                              child: Icon(Icons.cancel_outlined, size: 28,),
                            ),
                            contentPadding: EdgeInsets.only(left: 5, bottom: 5),
                            isDense: true,
                            filled: true,
                            fillColor: const Color(0xffededed),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'New York',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 18)

                          ),
                        ),
                      )

                    ],
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, int index) =>
                    InkWell(
                      onTap: () async{

                        inputValue = '';
                        controller.text = places.elementAt(index).placeName;
                        placeToSend = places.elementAt(index);
                        places.clear();
                        shouldSend = true;
                        FocusScope.of(context).unfocus();
                        setState(() {

                        });

                      },
                      splashColor: Colors.grey,
                      child: GooglePlaceItem(place: places.elementAt(index))
                    ),
                ),
              ),
              shouldSend ?
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff286ef0),
                            padding: EdgeInsets.symmetric(vertical: 20)
                        ),
                        onPressed: () async {

                          String? token = await FirebaseMessaging.instance.getToken();
                          geo.Location loc = (await geo.locationFromAddress(placeToSend!.placeName)).first;


                          Map<String, dynamic> map = app.constructRideRequestMap(
                              dateTime: widget.dateTime,
                              location: GeoPoint(locationData!.latitude!, locationData!.latitude!),
                              destination: GeoPoint(loc.latitude, loc.longitude),
                              token: token!);

                          RideRequest rideRequest = RideRequest.fromMap(map);
                          Future.delayed(const Duration(milliseconds: 2000), () => rideRequest.sendRequest());
                          indexToSend = -1;

                          //Isolate.spawn((message) { }, )

                          setState(() {

                          });
                        },
                        child: Text('Send request', style: TextStyle(fontSize: 24, letterSpacing: 1.0),),
                      ),
                    )
                  ],
                ),
              ): Container()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
