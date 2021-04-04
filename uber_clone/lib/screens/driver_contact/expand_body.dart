import 'package:flutter/material.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact_types/call_driver.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact_types/open_driver_profile.dart';
import 'package:uber_clone/screens/driver_contact/driver_contact_types/sms_driver.dart';

class ExpandBody extends StatefulWidget {


  final String phoneNumber;
  final String driverId;
  ExpandBody({required this.phoneNumber, required this.driverId});


  @override
  _ExpandBodyState createState() => _ExpandBodyState();
}

class _ExpandBodyState extends State<ExpandBody> with TickerProviderStateMixin{

  late AnimationController clickedController;
  bool showContactTypes = true;
  double begin = 0.5, end = 1;


  @override
  void initState() {
    super.initState();
    clickedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300)
    );
  }

  void rotateIcon() {
    clickedController.reset();
    if(!showContactTypes) {
      setState(() {
        begin = 0;
        end = 0.5;
        showContactTypes = !showContactTypes;
      });
    }
    else {
      setState(() {
        begin = 0.5;
        end = 1;
        showContactTypes = !showContactTypes;
      });
    }
    clickedController.forward();
  }


  @override
  void dispose() {
    clickedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: rotateIcon,
            splashColor: Colors.grey,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(widget.phoneNumber, style: TextStyle(fontSize: 18),),
                  Spacer(),
                  RotationTransition(
                      turns: Tween<double>(begin: begin, end: end).animate(clickedController),
                      child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black,)
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Divider(height: 30, color: Colors.grey, thickness: 0.5,)
        ),
        AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 200),
          child: showContactTypes ?
          Container(
            child: Column(
              children: [
                SMSDriver(phoneNumber: widget.phoneNumber,),
                CallDriver(phoneNumber: widget.phoneNumber,),
                OpenDriverProfile(driverId: widget.driverId),
              ],
            ),
          ) : Container(),

        ),
      ],
    );
  }
}
