import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/screens/user trips/sliver app bar/ride_types.dart';
import 'package:uber_clone/theme/palette.dart';
class UserTrips extends StatefulWidget {
  static const route = '/userTrips';
  @override
  _UserTripsState createState() => _UserTripsState();
}

class _UserTripsState extends State<UserTrips> with TickerProviderStateMixin {

  /*EdgeInsetsDirectional beforeIcon = EdgeInsetsDirectional.only(

  )*/

 double height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          print(isScrolled.toString());
          return<Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  pinned: true,
                  expandedHeight: 100,
                  actions: [
                    PickRideTypes()
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      //print(constraints.biggest.height.toString());
                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsetsDirectional.only(start: 100 - constraints.biggest.height * 0.4, bottom: 18),
                          title: Text('Choose a trip'),
                          stretchModes: [
                            StretchMode.zoomBackground
                          ],
                        background: Container(
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          ];
        },
        body: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if( height == 0) height = 200;
                    else height = 0;
                  });
                },
                child: Text('sadkjasd'),
              ),
              AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text('Past')),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text('Business')),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text('Upcoming')),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.red,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),

                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8, right: 20),

                  decoration: BoxDecoration(
                      color: Palette.dropdownGrey,
                      //borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Past', style: TextStyle(color: Colors.white, fontSize: 18),),
                      Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,))
                    ],
                  ),
                ),
              ),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red,
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Semir'),
                  ),
                ),
              )


            ],
          ),
        )
      ),
    );
  }
}
