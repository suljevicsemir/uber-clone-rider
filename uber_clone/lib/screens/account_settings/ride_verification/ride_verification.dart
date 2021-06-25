import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/settings/ride_verification.dart';

class RideVerification extends StatefulWidget {

  static const route = '/rideVerification';


  @override
  _RideVerificationState createState() => _RideVerificationState();
}

class _RideVerificationState extends State<RideVerification> {

  final EdgeInsets margin = EdgeInsets.symmetric(horizontal: 10);
  bool status = false;
  ScrollController controller = ScrollController();

  ScrollPhysics physics = ScrollPhysics();



  // this is not necessary, but this can be used to show hint to user that scrolling is possible
  _checkListSize() {
    if(controller.hasClients) {
      if( !(controller.position.maxScrollExtent.compareTo(0.0) > 0) ) {
        //can be scrolled
        setState(() {
          physics = NeverScrollableScrollPhysics();
        });
      }
    }
    else {
      Timer(const Duration(milliseconds: 10), () => _checkListSize());
    }
  }


  @override
  Widget build(BuildContext context) {
    _checkListSize();
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black
        ),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: physics,
                    controller: controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xffeef2fe),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async => Navigator.pop(context),
                                child: Container(
                                    margin: margin.copyWith(top: 20),
                                    child: Icon(Icons.clear, size: 36,)),
                              ),
                              Container(
                                margin: margin.copyWith(top: 10),
                                child: Text('Verify your rides', style: TextStyle(fontSize: 28),),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Image.asset('assets/images/uber_pin.jpg', fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width,)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              Text('Help make sure you get in the right car by verifying your ride with a PIN. You will receive a unique PIN for each trip that you will '
                                  'need to share with your driver when they pick you up, in order for the trip to start.',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text('Use PIN to verify rides', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)),
                                    Switch(
                                      value: Provider.of<RideVerificationProvider>(context).isUserUsingPIN,
                                      onChanged: (value) =>  Provider.of<RideVerificationProvider>(context, listen: false).isUserUsingPIN = value,
                                      activeColor: Colors.black,
                                      activeTrackColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                              Provider.of<RideVerificationProvider>(context).isUserUsingPIN ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Icon(Icons.nightlight_round, size: 35, ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Night time only', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                        Text('Enable PIN from 9 PM to 6 AM', style: TextStyle(fontSize: 17),)
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: Provider.of<RideVerificationProvider>(context).isNightTimeOnly,
                                    onChanged: (value) => Provider.of<RideVerificationProvider>(context, listen: false).isNightTimeOnly = value,
                                    activeColor: Colors.black,
                                    activeTrackColor: Colors.grey,
                                    inactiveTrackColor: Colors.grey,
                                  )
                                ],
                              ) : Container(),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  margin: margin.copyWith(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () async{

                        await Provider.of<RideVerificationProvider>(context, listen: false).updateVerification();
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text('Done', style: TextStyle(fontSize: 22),)
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
