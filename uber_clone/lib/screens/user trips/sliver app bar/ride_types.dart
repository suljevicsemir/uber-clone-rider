
import 'package:flutter/material.dart';
import 'package:uber_clone/theme/palette.dart';
class PickRideTypes extends StatefulWidget {
  @override
  _PickRideTypesState createState() => _PickRideTypesState();
}

class _PickRideTypesState extends State<PickRideTypes>  with TickerProviderStateMixin{

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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: rotateIcon,
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.white,
        radius: 30,
        child: Container(
          margin: EdgeInsets.only(top: 8, bottom: 8, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Palette.dropdownGrey,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Past', style: TextStyle(color: Colors.white, fontSize: 18),),
              RotationTransition(
                turns: Tween<double>(begin: begin, end: end).animate(clickedController),
                child: Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,)),
              )
            ],
          ),
        ),
      ),
    );
  }


}
