
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart' as aa;
import 'package:uber_clone/constants/api_key.dart' as api;
import 'package:uber_clone/models/google_place.dart';
import 'package:uber_clone/screens/place_search//google_place_item.dart';
import 'package:uuid/uuid.dart';

class WhereToSearch extends StatefulWidget {

  static const String route = '/whereToSearch';

  @override
  _WhereToSearchState createState() => _WhereToSearchState();
}

class _WhereToSearchState extends State<WhereToSearch> {



  aa.GooglePlace gp = aa.GooglePlace(api.apiKey);
  List<aa.AutocompletePrediction> list = [];

  final TextEditingController controller = TextEditingController();
  List<GooglePlace> places = <GooglePlace>[];
  String inputValue = '';
  final String token = Uuid().v4();
  Future<void> getPlaces(String input) async{

    if(input.isEmpty) {
      setState(() {
        this.places.clear();
      });
      return;
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = 'geocode';

    String request = '$baseURL?input=$input&key=${api.apiKey}&type=$type&sessiontoken=$token&fields=geometry';
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

  }

  @override
  Widget build(BuildContext context) {
    print('build is called' + DateTime.now().toString());
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black
        ),
        child: SafeArea(
          child: Container(
            //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BackButton(),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: TextField(
                            controller: controller,
                            onChanged: (String text) {
                              if( inputValue.compareTo(text) != 0) {
                                getPlaces(text);
                                inputValue = text;
                              }
                            },
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.teal.shade800,
                            cursorHeight: 24,
                            //autofocus: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: 'Where to?',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if(inputValue.compareTo('') == 0)
                                    return;
                                  controller.clear();
                                  setState(() {
                                    inputValue = '';
                                    places.clear();
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, size: 28,)
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
                        ),
                      ),
                    ],
                  ),
                ),

                /*Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: const TextField(
                    decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xffededed),
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        hintText: 'Home',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18)
                    ),
                  ),
                ),*/

                Expanded(
                  child: ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, int index) => GooglePlaceItem(place: places.elementAt(index))
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
