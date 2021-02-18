
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/trips_provider.dart';
import 'package:uber_clone/theme/palette.dart';
class RideTypePicker extends StatefulWidget {
  @override
  _RideTypePickerState createState() => _RideTypePickerState();
}

class _RideTypePickerState extends State<RideTypePicker>  with TickerProviderStateMixin{

  AnimationController clickedController;
  bool isClicked = false;
  double begin = 0, end = 0.5;



  @override
  void initState() {
    super.initState();
    clickedController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );



  }


  @override
  void dispose() {
    clickedController.dispose();
    super.dispose();
  }

  void rotateIcon() {
    clickedController.reset();
    if(!isClicked) {
      setState(() {
        begin = 0;
        end = 0.5;
        isClicked = !isClicked;
      });
    }
    else {
      setState(() {
        begin = 0.5;
        end = 1;
        isClicked = !isClicked;
      });
    }
    clickedController.forward();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: 20, top: 8, bottom: 8),
      child: ElevatedButton(
        child: Row(
          children: [
            Text(Provider.of<TripsProvider>(context).tripType.parseTripType(), style: TextStyle(color: Colors.white, fontSize: 16),),
            RotationTransition(
              turns: Tween<double>(begin: begin, end: end).animate(clickedController),
              child: Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,)),
            )
          ],
        ),
        onPressed: () {
          rotateIcon();
          Provider.of<TripsProvider>(context, listen: false).changeShown();
        },
        style: ElevatedButton.styleFrom(
          primary: Palette.dropdownGrey,
          padding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),

        ),
      ),
    );
  }


}
